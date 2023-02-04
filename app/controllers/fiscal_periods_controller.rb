class FiscalPeriodsController < ApplicationController
  before_action :set_fiscal_period, only: %i[ show edit update destroy ]

  # GET /fiscal_periods or /fiscal_periods.json
  def index
    @fiscal_periods = FiscalPeriod.all.order(id: :desc)
  end

  # GET /fiscal_periods/1 or /fiscal_periods/1.json
  def show
  end

  # GET /fiscal_periods/new
  def new
    @fiscal_period = FiscalPeriod.new
  end

  # GET /fiscal_periods/1/edit
  def edit
  end

  # POST /fiscal_periods or /fiscal_periods.json
  def create
    @fiscal_period = FiscalPeriod.new(fiscal_period_params)

    respond_to do |format|
      if @fiscal_period.save
        format.html { redirect_to fiscal_period_url(@fiscal_period), notice: "Költési időszak sikeresen létrehozva!" }
        format.json { render :show, status: :created, location: @fiscal_period }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fiscal_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fiscal_periods/1 or /fiscal_periods/1.json
  def update
    respond_to do |format|
      if @fiscal_period.update(fiscal_period_params)
        format.html { redirect_to fiscal_period_url(@fiscal_period), notice: "Költési időszak sikeresen frissítve!" }
        format.json { render :show, status: :ok, location: @fiscal_period }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fiscal_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fiscal_periods/1 or /fiscal_periods/1.json
  def destroy
    @fiscal_period.destroy

    respond_to do |format|
      format.html { redirect_to fiscal_periods_url, notice: "Költési időszak sikeresen törölve!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fiscal_period
      @fiscal_period = FiscalPeriod.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def fiscal_period_params
      params.require(:fiscal_period).permit(:start_at, :end_at, :name)
    end
end
