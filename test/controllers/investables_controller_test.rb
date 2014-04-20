require 'test_helper'

class InvestablesControllerTest < ActionController::TestCase
  setup do
    @investable = investables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:investables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create investable" do
    assert_difference('Investable.count') do
      post :create, investable: { isCompany: @investable.isCompany, name: @investable.name }
    end

    assert_redirected_to investable_path(assigns(:investable))
  end

  test "should show investable" do
    get :show, id: @investable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @investable
    assert_response :success
  end

  test "should update investable" do
    patch :update, id: @investable, investable: { isCompany: @investable.isCompany, name: @investable.name }
    assert_redirected_to investable_path(assigns(:investable))
  end

  test "should destroy investable" do
    assert_difference('Investable.count', -1) do
      delete :destroy, id: @investable
    end

    assert_redirected_to investables_path
  end
end
