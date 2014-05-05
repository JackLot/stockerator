require 'test_helper'

class IndividualPortfolioInvesetmentsControllerTest < ActionController::TestCase
  setup do
    @individual_portfolio_invesetment = individual_portfolio_invesetments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:individual_portfolio_invesetments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create individual_portfolio_invesetment" do
    assert_difference('IndividualPortfolioInvesetment.count') do
      post :create, individual_portfolio_invesetment: { amount: @individual_portfolio_invesetment.amount, buy_date: @individual_portfolio_invesetment.buy_date, individual_id: @individual_portfolio_invesetment.individual_id, percentage: @individual_portfolio_invesetment.percentage, portfolio_id: @individual_portfolio_invesetment.portfolio_id, sell_date: @individual_portfolio_invesetment.sell_date }
    end

    assert_redirected_to individual_portfolio_invesetment_path(assigns(:individual_portfolio_invesetment))
  end

  test "should show individual_portfolio_invesetment" do
    get :show, id: @individual_portfolio_invesetment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @individual_portfolio_invesetment
    assert_response :success
  end

  test "should update individual_portfolio_invesetment" do
    patch :update, id: @individual_portfolio_invesetment, individual_portfolio_invesetment: { amount: @individual_portfolio_invesetment.amount, buy_date: @individual_portfolio_invesetment.buy_date, individual_id: @individual_portfolio_invesetment.individual_id, percentage: @individual_portfolio_invesetment.percentage, portfolio_id: @individual_portfolio_invesetment.portfolio_id, sell_date: @individual_portfolio_invesetment.sell_date }
    assert_redirected_to individual_portfolio_invesetment_path(assigns(:individual_portfolio_invesetment))
  end

  test "should destroy individual_portfolio_invesetment" do
    assert_difference('IndividualPortfolioInvesetment.count', -1) do
      delete :destroy, id: @individual_portfolio_invesetment
    end

    assert_redirected_to individual_portfolio_invesetments_path
  end
end
