class AdsController < ApplicationController
  before_filter :authenticate_user!, except: [:index ]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  respond_to :html, :xml, :json
  # GET /ads
  # GET /ads.json
  def index
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    @ad = Ad.find(params[:id])
    @user = @ad.user
    @current_user = current_user
    @json = User.comments_user(@ad).to_gmaps4rails
    session[:return_to] = request.fullpath
    respond_with @ad
  end

  def show_all_ads_by_user
    @ads = current_user.ads
    respond_with @ads
  end
        		
  # GET /ads/new
  # GET /ads/new.json
  def new
    @ad = Ad.new
    @product = Product.new
    @brand = Brand.new
    @ad.product = @product
    @ad.brand = @brand

   @currencies = [] 
   major_currencies(Money::Currency::TABLE).each do |currency|  
     name = Money::Currency::TABLE[currency][:name]
     iso_code = Money::Currency::TABLE[currency][:iso_code]
     @currencies << [name, iso_code]
   end	
   respond_with @ad
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
    session[:brandname ] = params[:brand][:name]	

    @product_found = Product.findProduct(params[:product][:name], params[:product][:model])
    if @product_found
      @product = Product.find(@product_found)
    else
      @product = nil
    end
    
    if !session[:brandname].empty?
      @brand_found = Brand.findBrand(params[:brand][:name])
      if @brand_found
        @brand = Brand.find(@brand_found)
      else
        @brand = nil
      end
    else
      @brand = nil
    end

    if @product && @brand
      @brand_product_found = BrandProduct.findBrandProduct(@product, @brand) 
      if @brand_product_found    
        @brand_product = BrandProduct.find(@brand_product_found)
      else
        @brand_product = BrandProduct.new
      end
    else
      @brand_product = BrandProduct.new
    end

    if !@product
      @product = @brand_product.build_product(params[:product])
    else
      @brand_product.product = @product    
    end

    if !session[:brandname].empty?
      if !@brand
        @brand = @brand_product.build_brand(params[:brand])
      else
        @brand_product.brand = @brand
      end
    end

    @ad.brand_product = @brand_product
    @ads = current_user.feed

    if @ad.valid?
      @ad.save!	
      @follow_ad = @user.followad!(@ad)
      @notice = 'Ad was successfully created.'
      redirect_to @user
    else
      @ad.destroy
      render :template => 'users/show'
    end
  end

  # PUT /ads/1
  # PUT /ads/1.json
  def update
    @ad = Ad.find(params[:id])
    @user = current_user

    respond_to do |format|
      if @ad.update_attributes(params[:ad])
        format.html { redirect_to @user, notice: 'Ad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
