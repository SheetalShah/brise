require 'test_helper'

class CompanyManufacturedProductsControllerTest < ActionController::TestCase
  setup do
    @company_manufactured_product = company_manufactured_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_manufactured_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_manufactured_product" do
    assert_difference('CompanyManufacturedProduct.count') do
      post :create, company_manufactured_product: { company_id: @company_manufactured_product.company_id, product_id: @company_manufactured_product.product_id }
    end

    assert_redirected_to company_manufactured_product_path(assigns(:company_manufactured_product))
  end

  test "should show company_manufactured_product" do
    get :show, id: @company_manufactured_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company_manufactured_product
    assert_response :success
  end

  test "should update company_manufactured_product" do
    put :update, id: @company_manufactured_product, company_manufactured_product: { company_id: @company_manufactured_product.company_id, product_id: @company_manufactured_product.product_id }
    assert_redirected_to company_manufactured_product_path(assigns(:company_manufactured_product))
  end

  test "should destroy company_manufactured_product" do
    assert_difference('CompanyManufacturedProduct.count', -1) do
      delete :destroy, id: @company_manufactured_product
    end

    assert_redirected_to company_manufactured_products_path
  end
end
