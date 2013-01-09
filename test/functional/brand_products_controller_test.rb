require 'test_helper'

class BrandProductsControllerTest < ActionController::TestCase
  setup do
    @brand_product = brand_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brand_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brand_product" do
    assert_difference('BrandProduct.count') do
      post :create, brand_product: {  }
    end

    assert_redirected_to brand_product_path(assigns(:brand_product))
  end

  test "should show brand_product" do
    get :show, id: @brand_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brand_product
    assert_response :success
  end

  test "should update brand_product" do
    put :update, id: @brand_product, brand_product: {  }
    assert_redirected_to brand_product_path(assigns(:brand_product))
  end

  test "should destroy brand_product" do
    assert_difference('BrandProduct.count', -1) do
      delete :destroy, id: @brand_product
    end

    assert_redirected_to brand_products_path
  end
end
