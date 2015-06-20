class PagesController < ApplicationController
  before_filter :find_page, :only => :show
  before_action :set_page, only: [:edit, :update, :destroy]

  def find_page
    @page = Page.friendly.find(params[:id])

    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly_id.
    if request.path != page_path_helper(@page) && @page.published?
      return redirect_to page_path_helper(@page), :status => :moved_permanently
    end
  end

  # GET /pages
  # def index
  #   @pages = Page.all
  # end

  # GET /pages/1
  def show
    # @page = Page.friendly.find(params[:id])
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to @page, notice: 'Page was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /pages/1
  def update
    if @page.update(page_params)
      redirect_to @page, notice: 'Page was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /pages/1
  def destroy
    @page.destroy
    redirect_to pages_url, notice: 'Page was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page).permit(:user_id, :slug, :content, :published, :meta_description, :published_at)
    end
end
