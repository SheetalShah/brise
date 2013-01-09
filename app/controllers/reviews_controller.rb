class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @brand_product = BrandProduct.find(params[:brand_product_id])
    @review = @brand_product.reviews.build(params[:review])
    @review.user = current_user
    @rating = @brand_product.rates.build
    @rating.stars = params[:score]
    @rating.rater_id = current_user.id
    @rating.dimension = "quality"
    
    @user = current_user
    @product_brands = @brand_product.product.brands

    respond_to do |format|
      if @brand_product.valid?
        @brand_product.save!
        format.html { redirect_to @brand_product, notice: 'Review successfully posted.' }
        format.json { head :no_content }
      else
        format.html { render action: "show", controller: "brand_product" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @brand_product = @review.brand_product
    @review.destroy
    @rating = Rate.find_by_rater_id(current_user)
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to @brand_product }
      format.json { head :no_content }
    end
   
  end
end
