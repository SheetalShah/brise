class AdsController < ApplicationController
  before_filter :authenticate_user!, except: [:index ]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  # GET /ads
  # GET /ads.json
  def index
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @ad = Ad.find(params[:id])
    @product = @ad.build_product
    @brand = @ad.build_brand

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ad }
    end
  end

  def show_all_ads_by_user
    @ads = current_user.ads
    respond_to do |format|
      format.html
      format.json { render json: @ads }
    end
  end
        		
  # GET /ads/new
  # GET /ads/new.json
  def new
    @ad = Ad.new
    @product = Product.new
    @brand = Brand.new
    @ad.product = @product
    @ad.brand = @brand
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ad }
    end
  end

  # GET /ads/1/edit
  def edit
    @ad = Ad.find(params[:id])
  end

  # POST /ads
  # POST /ads.json
  def create
    @user = current_user
    @ad = current_user.ads.build(params[:ad])	
    @brand_product = BrandProduct.new
    @product = @brand_product.build_product(params[:product])
    @brand = @brand_product.build_brand(params[:brand])
    @ad.brand_product = @brand_product
    @ads = current_user.feed

    if @ad.valid?
      @ad.save!	
      @comment = @ad.comments.build(params[:comment])
      @notice = 'Ad was successfully created.'
      redirect_to @user
    else
      @ad.destroy
      @comment = Comment.new
      render :template => 'users/show'
    end
  end

  # PUT /ads/1
  # PUT /ads/1.json
  def update
    @ad = Ad.find(params[:id])

    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @user = current_user
    @ad = Ad.find(params[:id])
    @ad.destroy

    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

private

    def correct_user
      @ad = current_user.ads.find_by_id(params[:id])
      redirect_to root_url if @ad.nil?
    end
end
