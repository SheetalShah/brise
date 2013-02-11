class AdsController < ApplicationController
  before_filter :authenticate_user!, except: [:index ]
  #before_filter :correct_user, only: [:edit, :update, :destroy, :show, :myads, :myquotedads, :index]
  respond_to :html, :xml, :json
  # GET /ads
  # GET /ads.json
  def index
    @current_user = current_user
    user_id = params[:user_id] || current_user.id
    @user   = User.find( user_id )
    @json             = @user.to_gmaps4rails
    if( params[:ad_id].present? )
      @ad  = Ad.find( params[:ad_id] )
      @ads = @ad.ads_of_type(params[:ads_of_type])
      flash[:title] = params[:ads_of_type]
    elsif( params[:product_id].present? )
      @product = Product.find( params[:product_id] )
      @ads = @product.ads
      flash[:title] = "Product Ads"
    elsif( params[:show_ads_by].present? )
      @user.show_ads_by = params[:show_ads_by]
      flash[:title] = params[:show_ads_by]
      @ads = @user.feed
    else
      @ads = Ad.all
      flash[:title] = "N/A"
    end

    conditions = params[:conditions] || {}
    groupby    = params[:group_by] || "id"

    arr = []
    if( params[:q].present? )
      arr << Ad.search_query( params[:q] )
    end
    conditions.each do |k, value|
      arr << k + " = " + value
    end

    if arr.present?
      strC = arr.join( ' AND ' )
      @ads = Ad.where( strC )
    end
    @groupedads = @ads.group_by{|t| t[groupby]}
    respond_with @ads
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
        		
  # GET /ads/new
  # GET /ads/new.json
  def new
    @user = current_user
    @ad = current_user.ads.build(params[:ad])
    @ad.brand_product = BrandProduct.new
    @product = Product.new
    @brand = Brand.new
    @json = @user.to_gmaps4rails
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
      flash[:notice] = 'Ad was successfully created.'
      respond_with( @ads, :location => ads_url )
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
