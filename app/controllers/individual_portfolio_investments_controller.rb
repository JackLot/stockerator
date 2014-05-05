class IndividualPortfolioInvestmentsController < ApplicationController
  before_action :set_individual_portfolio_investment, only: [:show, :edit, :update, :destroy]

  # GET /individual_portfolio_investments
  # GET /individual_portfolio_investments.json
  def index
    @individual_portfolio_investments = IndividualPortfolioInvestment.all
  end

  # GET /individual_portfolio_investments/1
  # GET /individual_portfolio_investments/1.json
  def show
  end

  # GET /individual_portfolio_investments/new
  def new
    @individual_portfolio_investment = IndividualPortfolioInvestment.new
  end

  # GET /individual_portfolio_investments/1/edit
  def edit
  end

  # POST /individual_portfolio_investments
  # POST /individual_portfolio_investments.json
  def create
    @individual_portfolio_investment = IndividualPortfolioInvestment.new(individual_portfolio_investment_params)

    respond_to do |format|
      if @individual_portfolio_investment.save
        format.html { redirect_to @individual_portfolio_investment, notice: 'Individual portfolio investment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @individual_portfolio_investment }
      else
        format.html { render action: 'new' }
        format.json { render json: @individual_portfolio_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /individual_portfolio_investments/1
  # PATCH/PUT /individual_portfolio_investments/1.json
  def update
    respond_to do |format|
      if @individual_portfolio_investment.update(individual_portfolio_investment_params)
        format.html { redirect_to @individual_portfolio_investment, notice: 'Individual portfolio investment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @individual_portfolio_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /individual_portfolio_investments/1
  # DELETE /individual_portfolio_investments/1.json
  def destroy
    @individual_portfolio_investment.destroy
    respond_to do |format|
      format.html { redirect_to individual_portfolio_investments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_individual_portfolio_investment
      @individual_portfolio_investment = IndividualPortfolioInvestment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def individual_portfolio_investment_params
      params.require(:individual_portfolio_investment).permit(:individual_id, :portfolio_id, :amount, :buy_date, :sell_date, :percentage)
    end
end
