class IndividualPortfolioInvesetmentsController < ApplicationController
  before_action :set_individual_portfolio_invesetment, only: [:show, :edit, :update, :destroy]

  # GET /individual_portfolio_invesetments
  # GET /individual_portfolio_invesetments.json
  def index
    @individual_portfolio_invesetments = IndividualPortfolioInvesetment.all
  end

  # GET /individual_portfolio_invesetments/1
  # GET /individual_portfolio_invesetments/1.json
  def show
  end

  # GET /individual_portfolio_invesetments/new
  def new
    @individual_portfolio_invesetment = IndividualPortfolioInvesetment.new
  end

  # GET /individual_portfolio_invesetments/1/edit
  def edit
  end

  # POST /individual_portfolio_invesetments
  # POST /individual_portfolio_invesetments.json
  def create
    @individual_portfolio_invesetment = IndividualPortfolioInvesetment.new(individual_portfolio_invesetment_params)

    respond_to do |format|
      if @individual_portfolio_invesetment.save
        format.html { redirect_to @individual_portfolio_invesetment, notice: 'Individual portfolio invesetment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @individual_portfolio_invesetment }
      else
        format.html { render action: 'new' }
        format.json { render json: @individual_portfolio_invesetment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /individual_portfolio_invesetments/1
  # PATCH/PUT /individual_portfolio_invesetments/1.json
  def update
    respond_to do |format|
      if @individual_portfolio_invesetment.update(individual_portfolio_invesetment_params)
        format.html { redirect_to @individual_portfolio_invesetment, notice: 'Individual portfolio invesetment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @individual_portfolio_invesetment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /individual_portfolio_invesetments/1
  # DELETE /individual_portfolio_invesetments/1.json
  def destroy
    @individual_portfolio_invesetment.destroy
    respond_to do |format|
      format.html { redirect_to individual_portfolio_invesetments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_individual_portfolio_invesetment
      @individual_portfolio_invesetment = IndividualPortfolioInvesetment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def individual_portfolio_invesetment_params
      params.require(:individual_portfolio_invesetment).permit(:individual_id, :portfolio_id, :amount, :buy_date, :sell_date, :percentage)
    end
end
