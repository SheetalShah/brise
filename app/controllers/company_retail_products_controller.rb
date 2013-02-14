class CompanyRetailProductsController < ApplicationController
  # GET /company_retail_products
  # GET /company_retail_products.json
  def index
    @company_retail_products = CompanyRetailProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @company_retail_products }
    end
  end

  # GET /company_retail_products/1
  # GET /company_retail_products/1.json
  def show
    @company_retail_product = CompanyRetailProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company_retail_product }
    end
  end

  # GET /company_retail_products/new
  # GET /company_retail_products/new.json
  def new
    @company_retail_product = CompanyRetailProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company_retail_product }
    end
  end

  # GET /company_retail_products/1/edit
  def edit
    @company_retail_product = CompanyRetailProduct.find(params[:id])
  end

  # POST /company_retail_products
  # POST /company_retail_products.json
  def create
    @company_retail_product = CompanyRetailProduct.new(params[:company_retail_product])

    respond_to do |format|
      if @company_retail_product.save
        format.html { redirect_to @company_retail_product, notice: 'Company retail product was successfully created.' }
        format.json { render json: @company_retail_product, status: :created, location: @company_retail_product }
      else
        format.html { render action: "new" }
        format.json { render json: @company_retail_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /company_retail_products/1
  # PUT /company_retail_products/1.json
  def update
    @company_retail_product = CompanyRetailProduct.find(params[:id])

    respond_to do |format|
      if @company_retail_product.update_attributes(params[:company_retail_product])
        format.html { redirect_to @company_retail_product, notice: 'Company retail product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company_retail_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_retail_products/1
  # DELETE /company_retail_products/1.json
  def destroy
    @company_retail_product = CompanyRetailProduct.find(params[:id])
    @company_retail_product.destroy

    respond_to do |format|
      format.html { redirect_to company_retail_products_url }
      format.json { head :no_content }
    end
  end
end
