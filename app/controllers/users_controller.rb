class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, except: [:index ]
 # before_filter :correct_user, only: [:edit, :update, :show]
  before_filter :admin_user, only: :destroy


  # GET /users
  # GET /users.json
  def index
    @current_user = current_user
    id = session[:user_id] || params[:id] || current_user.id
    params[:id] = id
    @user         = User.find(params[:id])
    @user.show_users_by = session[:show_users_by]
    @users = @user.users
    respond_with @users
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
    else
      redirect_to user_session_path
    end 
  end

  def show_followedusers_ads
    session[:show_ads_by] = "followedusers"
    @user = User.find(params[:id])
    redirect_to @user
  end

  def show_followedproducts_ads
    session[:show_ads_by] = "followedproducts"
    @user = User.find(params[:id])
    redirect_to @user
  end

  def show_followedads_ads
    session[:show_ads_by] = "followedads"
    @user = User.find(params[:id])
    redirect_to @user
  end

  def show_all_ads
    session[:show_ads_by] = "all"
    @user = User.find(params[:id])
    redirect_to @user
  end

  def show_myads_ads
    session[:show_ads_by] = "myads"
    redirect_to ads_path
  end

  def show_myquoted_ads
    session[:show_ads_by] = "myquoted"
    redirect_to ads_path
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
	@user.build_company(params[:user][:company_attributes])
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

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
  
  def following
    @user = User.find(params[:id])
    session[:show_users_by] = "following"
    session[:user_id] = params[:id]
    redirect_to users_path
  end

  def following_ad
    session[:show_ads_by] = "followedads"
    session[:user_id] = params[:id]
    redirect_to ads_path
  end

  def following_product
    @title = "Following"
    @user = User.find(params[:id])
    session[:show_products_by] = "followedproducts"
    session[:user_id] = params[:id]
    redirect_to products_path
  end

  def followers
    session[:show_users_by] = "followers"
    session[:user_id] = params[:id]
    redirect_to users_path
  end
end
