require 'test_helper'

class IndividualPortfolioInvestmentsControllerTest < ActionController::TestCase
  setup do
    @individual_portfolio_investment = individual_portfolio_investments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:individual_portfolio_investments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create individual_portfolio_investment" do
    assert_difference('IndividualPortfolioInvestment.count') do
      post :create, individual_portfolio_investment: { amount: @individual_portfolio_investment.amount, buy_date: @individual_portfolio_investment.buy_date, individual_id: @individual_portfolio_investment.individual_id, percentage: @individual_portfolio_investment.percentage, portfolio_id: @individual_portfolio_investment.portfolio_id, sell_date: @individual_portfolio_investment.sell_date }
    end

    assert_redirected_to individual_portfolio_investment_path(assigns(:individual_portfolio_investment))
  end

  test "should show individual_portfolio_investment" do
    get :show, id: @individual_portfolio_investment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @individual_portfolio_investment
    assert_response :success
  end

  test "should update individual_portfolio_investment" do
    patch :update, id: @individual_portfolio_investment, individual_portfolio_investment: { amount: @individual_portfolio_investment.amount, buy_date: @individual_portfolio_investment.buy_date, individual_id: @individual_portfolio_investment.individual_id, percentage: @individual_portfolio_investment.percentage, portfolio_id: @individual_portfolio_investment.portfolio_id, sell_date: @individual_portfolio_investment.sell_date }
    assert_redirected_to individual_portfolio_investment_path(assigns(:individual_portfolio_investment))
  end

  test "should destroy individual_portfolio_investment" do
    assert_difference('IndividualPortfolioInvestment.count', -1) do
      delete :destroy, id: @individual_portfolio_investment
    end

    assert_redirected_to individual_portfolio_investments_path
  end
end
