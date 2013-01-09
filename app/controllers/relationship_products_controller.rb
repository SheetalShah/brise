class RelationshipProductsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @product = Product.find(params[:relationship_product][:followedproduct_id])
    @user = current_user
    current_user.followproduct!(@product)
    respond_to do |format|
#      session[:return_to] = request.fullpath
      format.html { redirect_to session[:return_to] }
      format.js
    end
  end

  def destroy
    @product = RelationshipProduct.find(params[:id]).followedproduct
    @user = current_user
    current_user.unfollowproduct!(@product)
    respond_to do |format|
      format.html { redirect_to session[:return_to] }
#      format.html { redirect_to @product }
      format.js
    end
  end
end

