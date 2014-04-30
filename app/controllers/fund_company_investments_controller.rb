class FundCompanyInvestmentsController < ApplicationController
  before_action :set_fund_company_investment, only: [:show, :edit, :update, :destroy]

  # GET /fund_company_investments
  # GET /fund_company_investments.json
  def index
    @fund_company_investments = FundCompanyInvestment.all
  end

  # GET /fund_company_investments/1
  # GET /fund_company_investments/1.json
  def show
  end

  # GET /fund_company_investments/new
  def new
    @fund_company_investment = FundCompanyInvestment.new
  end

  # GET /fund_company_investments/1/edit
  def edit
  end

  # POST /fund_company_investments
  # POST /fund_company_investments.json
  def create
    @fund_company_investment = FundCompanyInvestment.new(fund_company_investment_params)

    respond_to do |format|
      if @fund_company_investment.save
        format.html { redirect_to @fund_company_investment, notice: 'Fund company investment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fund_company_investment }
      else
        format.html { render action: 'new' }
        format.json { render json: @fund_company_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fund_company_investments/1
  # PATCH/PUT /fund_company_investments/1.json
  def update
    respond_to do |format|
      if @fund_company_investment.update(fund_company_investment_params)
        format.html { redirect_to @fund_company_investment, notice: 'Fund company investment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fund_company_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fund_company_investments/1
  # DELETE /fund_company_investments/1.json
  def destroy
    @fund_company_investment.destroy
    respond_to do |format|
      format.html { redirect_to fund_company_investments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fund_company_investment
      @fund_company_investment = FundCompanyInvestment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fund_company_investment_params
      params.require(:fund_company_investment).permit(:portfolio_id, :company_id, :amount, :buy_date, :sell_date)
    end
end
