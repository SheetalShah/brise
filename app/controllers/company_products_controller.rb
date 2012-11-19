class CompanyProductsController < ApplicationController
  # GET /company_products
  # GET /company_products.json
  def index
    @company_products = CompanyProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @company_products }
    end
  end

  # GET /company_products/1
  # GET /company_products/1.json
  def show
    @company_product = CompanyProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company_product }
    end
  end

  # GET /company_products/new
  # GET /company_products/new.json
  def new
    @company_product = CompanyProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company_product }
    end
  end

  # GET /company_products/1/edit
  def edit
    @company_product = CompanyProduct.find(params[:id])
  end

  # POST /company_products
  # POST /company_products.json
  def create
    @company_product = CompanyProduct.new(params[:company_product])

    respond_to do |format|
      if @company_product.save
        format.html { redirect_to @company_product, notice: 'Company product was successfully created.' }
        format.json { render json: @company_product, status: :created, location: @company_product }
      else
        format.html { render action: "new" }
        format.json { render json: @company_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /company_products/1
  # PUT /company_products/1.json
  def update
    @company_product = CompanyProduct.find(params[:id])

    respond_to do |format|
      if @company_product.update_attributes(params[:company_product])
        format.html { redirect_to @company_product, notice: 'Company product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /company_products/1
  # DELETE /company_products/1.json
  def destroy
    @company_product = CompanyProduct.find(params[:id])
    @company_product.destroy

    respond_to do |format|
      format.html { redirect_to company_products_url }
      format.json { head :no_content }
    end
  end
end
