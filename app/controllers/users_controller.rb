class UsersController < Devise::RegistrationsController
  before_filter :authenticate_user!, except: [:index ]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy


  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def home
    if user_signed_in?
      @user = current_user
      @ad = current_user.ads.build
      @ads = current_user.ads
      @comment = @ad.comments.build
      @current_user = current_user
      respond_to do |format|
        format.html { render action: "show" }
        format.json { render json: @user }
      end 	
    else
      redirect_to user_session_path
    end 
  end
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @user.show_ads_by = session[:show_ads_by] 
    @ad = @user.ads.build(params[:ad])
    @ads = @user.feed
    @comment = @ad.comments.build(params[:comment])
    @current_user = current_user
    @comments = Comment.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
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

  # GET /users/new
  # GET /users/new.json
  def new
    session[:signup_params] ||= {}
    @sowhat ={}
    @user = User.new(session[:signup_params])
    @user.avatar = @user.useravatar
    @user.signup_current_step = session[:signup_step]	
    @company = @user.build_company

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
      else
        if @user.valid?
          @user.signup_next_step
          @user.build_company
        end
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
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users

    respond_to do |format|
      format.html #following.html.erb
      format.json { render json: @users }
    end
  end

  def following_ad
    @title = "Following"
    @user = User.find(params[:id])

    respond_to do |format|
      format.html #following.html.erb
      format.json { render json: @users }
    end
  end

  def followers
    title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers


    respond_to do |format|
      format.html #followers.html.erb
      format.json { render json: @users }
    end
  end
end
