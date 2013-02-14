class UsersController < Devise::RegistrationsController
# require ActionController::RequestForgeryProtection::ClassMethods 
#  before_filter :authenticate_user!, except: [:index ]
 # before_filter :correct_user, only: [:edit, :update, :show]
#rescue_from ActionController::InvalidAuthenticityToken, :with => :your_strategy
#  before_filter :admin_user, only: :destroy
  respond_to :html, :json
  skip_before_filter :verify_authenticity_token  
  # GET /users
  # GET /users.json
  def index
    @current_user = current_user
    user_id = params[:user_id] || current_user.id
    @user   = User.find( user_id )
    @json             = @user.to_gmaps4rails
    if( params[:ad_id].present? )
      @ad         = Ad.find( params[:ad_id]) # if you want to find users following ads
      @users      = @ad.followers
      flash[:title] = "Following"
      respond_with( @ad, @users )
    elsif( params[ :product_id ] )
      @product    = Product.find( params[ :product_id ] )
      @object     = @product
      @users      = @product.userfeed( params[ :show_users_by] )
      flash[:title] = params[ :show_users_by]
      respond_with( @product, @users )
    elsif( params[ :q ] )
      @users = User.where( User.search_query( params[:q] ) )
      respond_with( @users )
    else
      @users = @user.userfeed( params[:show_users_by] )
      flash[:title] = params[:show_users_by]
      respond_with( @users )
    end
  end

  def home
    if user_signed_in?
      redirect_to current_user
    else
      redirect_to user_session_path
    end 
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if user_signed_in?
      @user             = User.find(params[:id])
      @user.show_ads_by = session[:show_ads_by] 
      @current_user     = current_user

      @ad               = @user.ads.build(params[:ad])
      @brand_product    = @ad.build_brand_product
      @comment          = @ad.comments.build(params[:comment])
      @ads              = @user.feed
      @json             = @user.to_gmaps4rails
       
      @userpage_right = session[:userpage_right ] || "adfeed"
      respond_with @user
    
    end 
  end

  # GET /users/new
  # GET /users/new.json
  def new
    session[:signup_params] ||= {}
    @user                     = User.new(session[:signup_params])
    @user.signup_current_step = session[:signup_step]	
    @company                  = @user.build_company

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    if params[:user][:avatar] 
      $temp = params[:user][:avatar]
    end
    
    params[:user][:avatar] = nil
    session[:signup_params].deep_merge!(params[:user]) if params[:user]
    @user = User.new(session[:signup_params])
    @user.avatar = $temp
    @user.signup_current_step = session[:signup_step]

    if @user
      if params[:back_button]
        @user.signup_previous_step
      elsif @user.signup_last_step?
        @user.save if @user.signup_all_valid?
      elsif @user.valid?
        @user.signup_next_step
        @user.build_company
      end
      session[:signup_step] = @user.signup_current_step
    end
    if @user.new_record?
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    else
      session[:signup_step] = session[:signup_params] = nil
      $temp = nil
      respond_to do |format|
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with @user
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

end
