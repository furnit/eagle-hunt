class Admin::Furniture::FabricColorsController < Admin::AdminbaseController
  def index
    @admin_furniture_fabric_colours = Admin::Furniture::FabricColor.all
  end
  
  def update
    color = Admin::Furniture::FabricColor.update(params[:id], params.require(:admin_furniture_fabric_color).permit(:name, :comment))
    respond_to do |format|
      if color.errors.empty?
        format.html { redirect_to admin_furniture_fabric_colors_path, notice: "دسته‌بندی رنگ پارچه «<b>#{params[:id]}</b>» با موفقیت ویرایش شد."  }
        format.json { render json: color, status: :ok, location: admin_furniture_fabric_colors_path }
      else
        format.html { render :edit }
        format.json { render json: color.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    # find the fabric color 
    item = Admin::Furniture::FabricColor.find(params[:id])
    # back up the color dependency IDs
    color_dep_ids = item.color_indices.select(:admin_furniture_fabric_id).distinct.map { |i| i.admin_furniture_fabric_id }
    # destroy color index dependencies
    item.color_indices.destroy_all
    # destroy the fabric color
    item.destroy
    # try to build new model, considering that we delete a cluster
    new_model = item.model
    new_model["k"] -= 1
    new_model["init"].delete_at(item.id - 1)
    # update models in database
    # we have to reset the ID count since the kmean model could refere to an ID which has been deleted before 
    Admin::Furniture::FabricColor.all.each.with_index { |e, index| e.id = (index + 1); e.model = new_model; e.save } 
    # try to re-categorise the depencies to others
    Admin::Furniture::Fabric.where(id: color_dep_ids).each { |ci| ci.determine_colour }
    
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_colors_path, notice: "دسته‌بندی رنگ پارچه «<b>#{params[:id]}</b>» با موفقیت حذف شد." }
      format.json { head :no_content }
    end
  end
  
  def compute
    Thread.new do
      k = params[:k].to_i || AppConfig.fabric.colours.cluster.k
      k = AppConfig.fabric.colours.cluster.k if k <= 0
      
      Admin::Furniture::FabricColor.cluster k, runs: AppConfig.fabric.colours.cluster.runs
      
      Admin::Furniture::Fabric::Fabric.all.each { |f| f.determine_colour }
      
      message = <<~sms
        دسته‌بندی رنگ‌ها با موفقیت به پایان رسید.
        
        مبل ویرا
        #{AppConfig.domain}
      sms
      AutoStart::SmsJob.send_proper message, to: current_user.phone_number
    end
    
    notice= "بعد از اتمام عملیات ایجاد دسته‌بندی رنگ‌ها به شما اطلاع داده خواهد شد."
    respond_to do |format|
      format.html { redirect_to admin_furniture_fabric_colors_path, notice: notice }
      format.json { render json: {message: notice}, status: :ok, location: admin_furniture_fabric_colors_path }
    end
  end
end
