class LinksController < ApplicationController
  before_action :set_link, only: %i[ show edit update destroy ]

  def visit
    @link = Link.find_by_slug(slug_params)

    respond_to do |format|
      if @link.nil?
        format.html { render file: 'public/404.html', status: :not_found, layout: false }
        format.json { render json: { error: 'Not found' }, status: :not_found }
      elsif !@link.enabled?
        format.html { render :disabled, status: :forbidden }
        format.json { render json: { error: 'Disabled' }, status: :forbidden }
      else
        @link.increment!(:clicks)
        format.html { safe_redirect(@link.url) }
        format.json { render json: { redirect_url: @link.url }, status: :ok }
      end
    end
  end

  # GET /links or /links.json
  def index
    @links = Link.all.order(created_at: :desc)
  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    authorize @link

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def set_link
    @link = Link.find(params[:id])
    authorize @link
  end

  def safe_redirect(url, fallback_url: root_path)
    uri = URI.parse(url)
    if uri.host.present? && uri.scheme.in?(%w[http https])
      redirect_to url, allow_other_host: true, status: 301
    else
      redirect_to fallback_url, status: 301
    end
  rescue URI::InvalidURIError
    redirect_to fallback_url, status: 301
  end

  def link_params
    params.require(:link).permit(:slug, :url, :title, :enabled)
  end

  def slug_params
    params.require(:slug).to_s.strip.gsub(/[^a-zA-Z0-9\-_]/, '')
  end
end
