class ModelsController < ApplicationController
  # GET /models
  # GET /models.json
  def index
    @models = Model.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @models }
    end
  end

  # GET /models/1
  # GET /models/1.json
  def show
    @model = Model.find(params[:id])
    @object = @model
    @user = current_user	
    @current_user = current_user	
    session[:return_to] = request.fullpath

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @model }
    end
  end

  # GET /models/new
  # GET /models/new.json
  def new
    @model = Model.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @model }
    end
  end

  # GET /models/1/edit
  def edit
    @model = Model.find(params[:id])
  end

  # POST /models
  # POST /models.json
  def create
    @model = Model.new(params[:model])

    if( params[ :product_id ] )
	@product = Product.find( params[:product_id] )
        @brand   = Brand.find( params[:brand_id ] )
	if BrandProduct.find_by_product_id_and_brand_id_and_model_id( params[:product_id], params[:brand_id], nil )
          @brand_product = BrandProduct.find_by_product_id_and_brand_id_and_model_id( params[:product_id], params[:brand_id], nil )
        else
          @brand_product = BrandProduct.new
        end

        @brand_product.product = @product
        @brand_product.brand   = @brand
        @brand_product.model   = @model
	
      respond_to do |format|
        if @brand_product.save
          format.html { redirect_to @product, notice: 'Brand was successfully created.' }
          format.json { render json: @product, status: :created, location: @product }
        else
          format.html { render action: "new" }
          format.json { render json: @brand.errors, status: :unprocessable_entity }
        end
       end
    else
      respond_to do |format|
        if @model.save
          format.html { redirect_to @product, notice: 'Brand was successfully created.' }
          format.json { render json: @product, status: :created, location: @product }
        else
          format.html { render action: "new" }
          format.json { render json: @brand.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.json
  def update
    @model = Model.find(params[:id])

    respond_to do |format|
      if @model.update_attributes(params[:model])
        format.html { redirect_to @model, notice: 'Model was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.json
  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    respond_to do |format|
      format.html { redirect_to models_url }
      format.json { head :no_content }
    end
  end
end
