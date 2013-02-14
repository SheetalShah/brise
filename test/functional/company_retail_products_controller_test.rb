require 'test_helper'

class CompanyRetailProductsControllerTest < ActionController::TestCase
  setup do
    @company_retail_product = company_retail_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_retail_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_retail_product" do
    assert_difference('CompanyRetailProduct.count') do
      post :create, company_retail_product: { company_id: @company_retail_product.company_id, product_id: @company_retail_product.product_id }
    end

    assert_redirected_to company_retail_product_path(assigns(:company_retail_product))
  end

  test "should show company_retail_product" do
    get :show, id: @company_retail_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company_retail_product
    assert_response :success
  end

  test "should update company_retail_product" do
    put :update, id: @company_retail_product, company_retail_product: { company_id: @company_retail_product.company_id, product_id: @company_retail_product.product_id }
    assert_redirected_to company_retail_product_path(assigns(:company_retail_product))
  end

  test "should destroy company_retail_product" do
    assert_difference('CompanyRetailProduct.count', -1) do
      delete :destroy, id: @company_retail_product
    end

    assert_redirected_to company_retail_products_path
  end
end
