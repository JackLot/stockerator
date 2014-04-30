require 'test_helper'

class FundCompanyInvestmentsControllerTest < ActionController::TestCase
  setup do
    @fund_company_investment = fund_company_investments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fund_company_investments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fund_company_investment" do
    assert_difference('FundCompanyInvestment.count') do
      post :create, fund_company_investment: { amount: @fund_company_investment.amount, buy_date: @fund_company_investment.buy_date, company_id: @fund_company_investment.company_id, portfolio_id: @fund_company_investment.portfolio_id, sell_date: @fund_company_investment.sell_date }
    end

    assert_redirected_to fund_company_investment_path(assigns(:fund_company_investment))
  end

  test "should show fund_company_investment" do
    get :show, id: @fund_company_investment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fund_company_investment
    assert_response :success
  end

  test "should update fund_company_investment" do
    patch :update, id: @fund_company_investment, fund_company_investment: { amount: @fund_company_investment.amount, buy_date: @fund_company_investment.buy_date, company_id: @fund_company_investment.company_id, portfolio_id: @fund_company_investment.portfolio_id, sell_date: @fund_company_investment.sell_date }
    assert_redirected_to fund_company_investment_path(assigns(:fund_company_investment))
  end

  test "should destroy fund_company_investment" do
    assert_difference('FundCompanyInvestment.count', -1) do
      delete :destroy, id: @fund_company_investment
    end

    assert_redirected_to fund_company_investments_path
  end
end
