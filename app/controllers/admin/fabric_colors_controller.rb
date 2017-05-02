class Admin::FabricColorsController < Admin::AdminbaseController
  def index
    @admin_fabric_colours = Admin::FabricColor.all
  end
  
  def update
    color = Admin::FabricColor.update(params[:id], params.require(:admin_fabric_color).permit(:name, :comment))
    respond_to do |format|
      if color.errors.empty?
        format.html { redirect_to admin_fabric_colors_path, notice: "دسته‌بندی رنگ پارچه «<b>#{params[:id]}</b>» با موفقت ویرایش شد."  }
        format.json { render json: color, status: :ok, location: admin_fabric_colors_path }
      else
        format.html { render :edit }
        format.json { render json: color.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    Admin::FabricColor.destroy_all(id: params[:id])
    respond_to do |format|
      format.html { redirect_to admin_fabric_colors_path, notice: "دسته‌بندی رنگ پارچه «<b>#{params[:id]}</b>» با موفقت حذف شد." }
      format.json { head :no_content }
    end
  end
  
  def compute
    Thread.new do 
      colours = [];
      colour_sampling = AppConfig.fabric.colours.cluster.colour_sampling
      # collect all image data to cluster
      Admin::Fabric.all.map { |f| f.images.map { |i| i.file.file } }.flatten.each do |file|
        img = Magick::Image.read(file).first
        img.scale(colour_sampling[0], colour_sampling[1]).each_pixel { |pixel| colours << [pixel.red, pixel.green, pixel.blue].map { |p| p/= 256 } }
      end
      
      centers = []
      k = params[:k].to_i || AppConfig.fabric.colours.cluster.k
      k = AppConfig.fabric.colours.cluster.k if k <= 0
      
      kmeans = KMeansClusterer.run(k, colours, runs: AppConfig.fabric.colours.cluster.runs)
      
      kmeans.clusters.each { |cluster| centers << cluster.centroid.data.to_a.each_slice(3).to_a }
      
      # delete all indexed records
      Admin::FabricColorIndex.delete_all
      # delete all color cluster records
      Admin::FabricColor.delete_all
      
      centers.each.with_index do |c, cindex|
        color = "#" + c.flatten.map { |i| i.to_i.to_s(16) }.map { |i| i.length == 1 ? "0#{i}" : i }.join
        Admin::FabricColor.create(id: cindex + 1, value: color, model: {k: k, init: centers.map { |i| i.flatten }, runs: AppConfig.fabric.colours.cluster.runs})
      end
      
      #
      # => TODO: categorize every fabric's color based on clusters
      #
      
      message = <<~sms
        دسته‌بندی رنگ‌ها با موفقیت به پایان رسید.
        
        مبل ویرا
        #{AppConfig.domain}
      sms
      AutoStart::SmsJob.send_proper message, to: current_user.phone_number
    end
    
    notice= "بعد از اتمام عملیات ایجاد دسته‌بندی رنگ‌ها به شما اطلاع داده خواهد شد."
    respond_to do |format|
      format.html { redirect_to admin_fabric_colors_path, notice: notice }
      format.json { render json: {message: notice}, status: :ok, location: admin_fabric_colors_path }
    end
  end
end
