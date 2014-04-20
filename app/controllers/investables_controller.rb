class InvestablesController < ApplicationController
  before_action :set_investable, only: [:show, :edit, :update, :destroy]

  # GET /investables
  # GET /investables.json
  def index
    @investables = Investable.all
  end

  # GET /investables/1
  # GET /investables/1.json
  def show
  end

  # GET /investables/new
  def new
    @investable = Investable.new
  end

  # GET /investables/1/edit
  def edit
  end

  # POST /investables
  # POST /investables.json
  def create
    @investable = Investable.new(investable_params)

    respond_to do |format|
      if @investable.save
        format.html { redirect_to @investable, notice: 'Investable was successfully created.' }
        format.json { render action: 'show', status: :created, location: @investable }
      else
        format.html { render action: 'new' }
        format.json { render json: @investable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investables/1
  # PATCH/PUT /investables/1.json
  def update
    respond_to do |format|
      if @investable.update(investable_params)
        format.html { redirect_to @investable, notice: 'Investable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @investable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investables/1
  # DELETE /investables/1.json
  def destroy
    @investable.destroy
    respond_to do |format|
      format.html { redirect_to investables_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investable
      @investable = Investable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def investable_params
      params.require(:investable).permit(:name, :isCompany)
    end
end
