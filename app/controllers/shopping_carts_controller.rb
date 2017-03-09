class ShoppingCartsController < ApplicationController
  
  # POST /shopping_carts.json
  def create
    @shopping_cart = ShoppingCart.new(shopping_cart_params)
    @shopping_cart.user_id = current_user.id if user_signed_in?
    count = 0;
    respond_to do |format|
      if @shopping_cart.valid? or not user_signed_in?
        # save the model in session or db
        if user_signed_in?
          @shopping_cart.save
          count = ShoppingCart.where("user_id = ?", current_user.id).count
        else
          (session[:shopping_cart] ||= []) << shopping_cart_params[:furniture_id]
          count = session[:shopping_cart].length;
          # for rendering views correctly these are needed
          @shopping_cart.id = 0;
          @shopping_cart.readonly!
        end
        format.json { render :json => { _count: count, id: @shopping_cart.id }, status: :created, location: @shopping_cart }
      else
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /shopping_carts/1.json
  def destroy
    count = 0;
    if user_signed_in?
      ShoppingCart.where('id = ? AND user_id = ? AND furniture_id = ?', params[:id], current_user.id, shopping_cart_params[:furniture_id]).first.destroy
      count = ShoppingCart.where("user_id = ?", current_user.id).count
    else
      if session[:shopping_cart]
        session[:shopping_cart].delete(shopping_cart_params[:furniture_id])
        count = session[:shopping_cart].length;
      end
    end
    respond_to do |format|
      format.json  { render :json => { _count: count } }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def shopping_cart_params
      params.require(:shopping_cart).permit(:furniture_id)
    end
end
