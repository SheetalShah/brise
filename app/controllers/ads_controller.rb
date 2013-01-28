class AdsController < ApplicationController
  before_filter :authenticate_user!, except: [:index ]
  #before_filter :correct_user, only: [:edit, :update, :destroy, :show, :myads, :myquotedads, :index]
  respond_to :html, :xml, :json
  # GET /ads
  # GET /ads.json
  def index
    @current_user = current_user
    id = session[:user_id] || params[:id] || current_user.id
    params[:id] = id
    @user         = User.find(params[:id])
    @user.show_ads_by = session[:show_ads_by]
    @ads = @user.feed
    respond_with @ads
  end

  def myads
    session[:show_ads_by] = "myads"
    render :action => "index"
  end

  def myquotedads
    session[:show_ads_by] = "myquotedads"
    render :action => "index"
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
    @user = current_user
    @ad = current_user.ads.build(params[:ad])
    @ad.brand_product = BrandProduct.new
    @product = Product.new
    @brand = Brand.new
    session[:userpage_right] = "adpost_form"
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
    @current_user = current_user
    @ads = Ad.all

    @ad   = current_user.ads.build(params[:ad])
    if params[:brand_product][:id].empty?
      @product       = Product.find_by_name_and_model(params[:product][:name], params[:product][:model]) 
      @brand         = Brand.find_by_name(params[:brand][:name]) unless params[:brand][:name].empty?
      @brand_product = BrandProduct.find_by_brand_id_and_product_id(@brand, @product) || nil

      @brand_product = @brand_product || BrandProduct.new
      @brand_product.product = @product || @brand_product.build_product(params[:product]) if !@brand_product.product
      @brand_product.brand = @brand || @brand_product.build_brand(params[:brand]) if !@brand_product.brand
    else
      @brand_product = BrandProduct.find(params[:brand_product][:id].to_i)
    end

    @ad.brand_product = @brand_product


    if @ad.valid?
      @ad.save!
      @follow_ad = @user.followad!(@ad) # by default user who created the ad follows it
      respond_with @user
    else
      render action: "new"
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
