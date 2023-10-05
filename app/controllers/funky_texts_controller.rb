class FunkyTextsController < ApplicationController
  before_action :set_funky_text, only: %i[ show edit update destroy ]
  # GET /funky_texts or /funky_texts.json
  def index
    @funky_texts = FunkyText.all.order(created_at: :desc)
  end

  # GET /funky_texts/1 or /funky_texts/1.json
  def show

  end

  # GET /funky_texts/new
  def new
    @funky_text = FunkyText.new
  end

  # GET /funky_texts/1/edit
  def edit
  end

  # POST /funky_texts or /funky_texts.json
  def create
    @funky_text = FunkyText.new(funky_text_params)

    respond_to do |format|
      if @funky_text.save
        format.html { redirect_to funky_text_url(@funky_text), notice: "A szöveget sikeresen létrehoztuk!" }
        format.json { render :show, status: :created, location: @funky_text }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @funky_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funky_texts/1 or /funky_texts/1.json
  def update
    respond_to do |format|
      if @funky_text.update(funky_text_params)
        format.html { redirect_to funky_text_url(@funky_text), notice: "A szöveget sikeresen frissítettük!" }
        format.json { render :show, status: :ok, location: @funky_text }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @funky_text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funky_texts/1 or /funky_texts/1.json
  def destroy
    @funky_text.destroy

    respond_to do |format|
      format.html { redirect_to funky_texts_url, notice: "A szöveget sikeresen töröltük" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funky_text
      @funky_text = FunkyText.all.order(id: :desc)
      authorize @funky_text
    end

    # Only allow a list of trusted parameters through.
    def funky_text_params
      params.require(:funky_text).permit(:title)
    end
end
