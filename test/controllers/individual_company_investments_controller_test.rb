require 'test_helper'

class IndividualCompanyInvestmentsControllerTest < ActionController::TestCase
  setup do
    @individual_company_investment = individual_company_investments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:individual_company_investments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create individual_company_investment" do
    assert_difference('IndividualCompanyInvestment.count') do
      post :create, individual_company_investment: { amount: @individual_company_investment.amount, buy_date: @individual_company_investment.buy_date, company_id: @individual_company_investment.company_id, individual_id: @individual_company_investment.individual_id, sell_date: @individual_company_investment.sell_date }
    end

    assert_redirected_to individual_company_investment_path(assigns(:individual_company_investment))
  end

  test "should show individual_company_investment" do
    get :show, id: @individual_company_investment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @individual_company_investment
    assert_response :success
  end

  test "should update individual_company_investment" do
    patch :update, id: @individual_company_investment, individual_company_investment: { amount: @individual_company_investment.amount, buy_date: @individual_company_investment.buy_date, company_id: @individual_company_investment.company_id, individual_id: @individual_company_investment.individual_id, sell_date: @individual_company_investment.sell_date }
    assert_redirected_to individual_company_investment_path(assigns(:individual_company_investment))
  end

  test "should destroy individual_company_investment" do
    assert_difference('IndividualCompanyInvestment.count', -1) do
      delete :destroy, id: @individual_company_investment
    end

    assert_redirected_to individual_company_investments_path
  end
end
