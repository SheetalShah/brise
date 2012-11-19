require 'test_helper'

class CompanyProductsControllerTest < ActionController::TestCase
  setup do
    @company_product = company_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_product" do
    assert_difference('CompanyProduct.count') do
      post :create, company_product: { company: @company_product.company, product: @company_product.product }
    end

    assert_redirected_to company_product_path(assigns(:company_product))
  end

  test "should show company_product" do
    get :show, id: @company_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company_product
    assert_response :success
  end

  test "should update company_product" do
    put :update, id: @company_product, company_product: { company: @company_product.company, product: @company_product.product }
    assert_redirected_to company_product_path(assigns(:company_product))
  end

  test "should destroy company_product" do
    assert_difference('CompanyProduct.count', -1) do
      delete :destroy, id: @company_product
    end

    assert_redirected_to company_products_path
  end
end
