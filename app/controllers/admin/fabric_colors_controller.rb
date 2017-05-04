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
      
      k = params[:k].to_i || AppConfig.fabric.colours.cluster.k
      k = AppConfig.fabric.colours.cluster.k if k <= 0
           
      Admin::FabricColor.cluster k, runs: AppConfig.fabric.colours.cluster.runs
      
      Admin::Fabric.all.each { |f| f.determine_colour }
      
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
