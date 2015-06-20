class PagesController < ApplicationController
  before_filter :find_page, :only => :show
  before_action :set_user, only: [:new, :edit, :create, :update]

  def find_page
    # raise params.to_json
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
    # @page is set in find_page
  end

  # GET /pages/new
  def new
    # @page = Page.new
    @page = @user.pages.build
  end

  # GET /pages/1/edit
  def edit
    @page = @user.pages.friendly.find(params[:id])
  end

  # POST /pages
  def create
    # @page = Page.new(page_params)
    @page = @user.pages.build(page_params)

    if @page.save
      redirect_to @page, notice: 'Page was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /pages/1
  def update
    @page = @user.pages.friendly.find(params[:id])

    if @page.update(page_params)
      redirect_to page_path_helper(@page), notice: 'Page was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /pages/1
  def destroy
    @user = current_user
    @page = @user.pages.friendly.find(params[:id])
    @page.destroy

    redirect_to dashboard_path, notice: 'Page was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      # @page = Page.find(params[:id])
      @user = User.friendly.find(params[:user_id])

    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page).permit(:user_id, :title, :slug, :content, :published, :meta_description, :published_at)
    end
end
