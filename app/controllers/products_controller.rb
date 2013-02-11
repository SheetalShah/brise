class ProductsController < ApplicationController
  respond_to :html, :xml, :json
  # GET /products
  # GET /products.json
  def index
    @current_user = current_user
    user_id       = params[:user_id] || current_user.id
    @user         = User.find(user_id)
    @json             = @user.to_gmaps4rails
    @products     = Product.feed(@user, params[:show_products_by])
    flash[:title] = params[:show_products_by]
    respond_with @products
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @user = current_user	
    @product = Product.find(params[:id])
    @product_brands = @product.brands
    @current_user = current_user	
    session[:return_to] = request.fullpath

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    if( params[:product_id].present? )
      @product.name = Product.find(params[:product_id]).name
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    if( params[:product_id].present? )
      @product.name = Product.find(params[:product_id]).name
    end
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
   
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
