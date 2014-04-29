class IndividualCompanyInvestmentsController < ApplicationController
  before_action :set_individual_company_investment, only: [:show, :edit, :update, :destroy]

  # GET /individual_company_investments
  # GET /individual_company_investments.json
  def index
    @individual_company_investments = IndividualCompanyInvestment.all
  end

  # GET /individual_company_investments/1
  # GET /individual_company_investments/1.json
  def show
  end

  # GET /individual_company_investments/new
  def new
    @individual_company_investment = IndividualCompanyInvestment.new
  end

  # GET /individual_company_investments/1/edit
  def edit
  end

  # POST /individual_company_investments
  # POST /individual_company_investments.json
  def create
    @individual_company_investment = IndividualCompanyInvestment.new(individual_company_investment_params)

    respond_to do |format|
      if @individual_company_investment.save
        format.html { redirect_to @individual_company_investment, notice: 'Individual company investment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @individual_company_investment }
      else
        format.html { render action: 'new' }
        format.json { render json: @individual_company_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /individual_company_investments/1
  # PATCH/PUT /individual_company_investments/1.json
  def update
    respond_to do |format|
      if @individual_company_investment.update(individual_company_investment_params)
        format.html { redirect_to @individual_company_investment, notice: 'Individual company investment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @individual_company_investment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /individual_company_investments/1
  # DELETE /individual_company_investments/1.json
  def destroy
    @individual_company_investment.destroy
    respond_to do |format|
      format.html { redirect_to individual_company_investments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_individual_company_investment
      @individual_company_investment = IndividualCompanyInvestment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def individual_company_investment_params
      params.require(:individual_company_investment).permit(:individual_id, :company_id, :amount, :buy_date, :sell_date)
    end
end
