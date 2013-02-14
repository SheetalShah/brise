class CompanyManufacturedProductsController < ApplicationController
  # GET /company_manufactured_products
  # GET /company_manufactured_products.json
  def index
    @company_manufactured_products = CompanyManufacturedProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @company_manufactured_products }
    end
  end

  # GET /company_manufactured_products/1
  # GET /company_manufactured_products/1.json
  def show
    @company_manufactured_product = CompanyManufacturedProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company_manufactured_product }
    end
  end

  # GET /company_manufactured_products/new
  # GET /company_manufactured_products/new.json
  def new
    @company_manufactured_product = CompanyManufacturedProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company_manufactured_product }
    end
  end

  # GET /company_manufactured_products/1/edit
  def edit
    @company_manufactured_product = CompanyManufacturedProduct.find(params[:id])
  end

  # POST /company_manufactured_products
  # POST /company_manufactured_products.json
  def create
    @company_manufactured_product = CompanyManufacturedProduct.new(params[:company_manufactured_product])

    respond_to do |format|
      if @company_manufactured_product.save
        format.html { redirect_to @company_manufactured_product, notice: 'Company manufactured product was successfully created.' }
        format.json { render json: @company_manufactured_product, status: :created, location: @company_manufactured_product }
      else
        format.html { render action: "new" }
        format.json { render json: @company_manufactured_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /company_manufactured_products/1
  # PUT /company_manufactured_products/1.json
  def update
    @company_manufactured_product = CompanyManufacturedProduct.find(params[:id])

    respond_to do |format|
      if @company_manufactured_product.update_attributes(params[:company_manufactured_product])
        format.html { redirect_to @company_manufactured_product, notice: 'Company manufactured product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company_manufactured_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_manufactured_products/1
  # DELETE /company_manufactured_products/1.json
  def destroy
    @company_manufactured_product = CompanyManufacturedProduct.find(params[:id])
    @company_manufactured_product.destroy

    respond_to do |format|
      format.html { redirect_to company_manufactured_products_url }
      format.json { head :no_content }
    end
  end
end
