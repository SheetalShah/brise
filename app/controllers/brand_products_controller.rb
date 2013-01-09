class BrandProductsController < ApplicationController
  # GET /brand_products
  # GET /brand_products.json
  def index
    @brand_products = BrandProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @brand_products }
    end
  end

  # GET /brand_products/1
  # GET /brand_products/1.json
  def show
    @brand_product = BrandProduct.find(params[:id])
    @user = current_user	
    @product = @brand_product.product
    @brand = @brand_product.brand
    @product_brands = @product.brands

    @reviews = @brand_product.reviews
    @review = @brand_product.reviews.build

    @current_user = current_user
    
    session[:return_to] = request.fullpath
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand_product }
    end
  end

  # GET /brand_products/new
  # GET /brand_products/new.json
  def new
    @brand_product = BrandProduct.new
    @review  = @product.reviews.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand_product }
    end
  end

  # GET /brand_products/1/edit
  def edit
    @brand_product = BrandProduct.find(params[:id])
  end

  # POST /brand_products
  # POST /brand_products.json
  def create
    @brand_product = BrandProduct.new(params[:brand_product])
    @review  = @product.reviews.build(params[:brand_product][:review])
    respond_to do |format|
      if @brand_product.save
        format.html { redirect_to @brand_product, notice: 'Brand product was successfully created.' }
        format.json { render json: @brand_product, status: :created, location: @brand_product }
      else
        format.html { render action: "new" }
        format.json { render json: @brand_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /brand_products/1
  # PUT /brand_products/1.json
  def update
    @brand_product = BrandProduct.find(params[:id])

    respond_to do |format|
      if @brand_product.update_attributes(params[:brand_product])
        format.html { redirect_to @brand_product, notice: 'Brand product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brand_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /brand_products/1
  # DELETE /brand_products/1.json
  def destroy
    @brand_product = BrandProduct.find(params[:id])
    @brand_product.destroy

    respond_to do |format|
      format.html { redirect_to @brand_product }
      format.json { head :no_content }
    end
  end
end
