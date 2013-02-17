class QueriesController < ApplicationController
  respond_to :html, :xml, :json
  # GET /queries
  # GET /queries.json
  def index
    @queries = Query.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @queries }
    end
  end

  # GET /queries/1
  # GET /queries/1.json
  def show
    @query = Query.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @query }
    end
  end

  # GET /queries/new
  # GET /queries/new.json
  def new
    @product = Product.find(params[:product_id] )
    @query = Query.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @query }
    end
  end

  # POST /queries
  # POST /queries.json
  def create
    @product = Product.find(params[:product_id] )
    @user = current_user
    @users   = @product.userfeed( params[ :show_users_by] )
 
    params[:query][:to] = @users.collect(&:display_name)
    @query = Query.new(params[:query])
    @query.from = current_user.email
    @query.send_query(@users, @product )

    
    @query.save
    respond_with(@user)
  end

  # DELETE /queries/1
  # DELETE /queries/1.json
  def destroy
    @query = Query.find(params[:id])
    @query.destroy

    respond_to do |format|
      format.html { redirect_to queries_url }
      format.json { head :no_content }
    end
  end
end
