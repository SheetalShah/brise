class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @product = Product.find_by_id(params[:product_id])
    @rating = Rating.new(params[:rating])
    @rating.product_id = @product.id
    @rating.user_id = current_user.id
    if @rating.save
      respond_to do |format|
        format.html { redirect_to product_path(@product), :notice => "Your rating has been saved" }
        format.js
      end
    end
  end

  def update
    @product = Product.find_by_id(params[:product_id])
    @rating = current_user.ratings.find_by_product_id(@product.id)
    if @rating.update_attributes(params[:rating])
      respond_to do |format|
        format.html { redirect_to product_path(@product), :notice => "Your rating has been updated" }
        format.js
      end
    end
  end
end

