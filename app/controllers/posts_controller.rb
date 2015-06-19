class PostsController < ApplicationController
  # GET users/1/posts
  # GET users/1/posts.json

  before_filter :find_post, :only => :show

  def find_post
    @post = Post.friendly.find(params[:id])

    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
      if request.path != blogpost_path(@post) && @post.published? && @post.url_contains_date?
        return redirect_to blogpost_path(@post), :status => :moved_permanently
      end
  end

  def index
    # @user = User.friendly.find(params[:user_id])
    # @posts = @user.posts

    @posts = Post.publisheds.order("published_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  def feed
    # this will be the name of the feed displayed on the feed reader
      @title = "AndrewGertig.com"

      # the news items
      @posts = Post.publisheds.order("published_at DESC")

      # this will be our Feed's update timestamp
      @updated = @posts.first.updated_at unless @posts.empty?

      respond_to do |format|
        format.atom { render :layout => false }

        # we want the RSS feed to redirect permanently to the ATOM feed
        format.rss { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
      end
  end

  # GET users/1/posts/1
  # GET users/1/posts/1.json
  def show
    # @user = User.friendly.find(params[:user_id])
    # @post = @user.posts.find(params[:id])
    # @post = Post.find_by_slug(params[:id])
    @post = Post.friendly.find(params[:id])
    @user = @post.user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  # GET users/1/posts/new
  # GET users/1/posts/new.json
  def new
    @user = User.friendly.find(params[:user_id])
    @post = @user.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET users/1/posts/1/edit
  def edit
    @user = User.friendly.find(params[:user_id])
    @post = @user.posts.friendly.find(params[:id])
  end

  # POST users/1/posts
  # POST users/1/posts.json
  def create
    @user = User.friendly.find(params[:user_id])
    @post = @user.posts.build(clean_params)

    puts clean_params.to_yaml

    respond_to do |format|
      if @post.save
        # format.html { redirect_to([@post.user, @post], :notice => 'Post was successfully created.') }
        format.html { redirect_to(blogpost_path(@post), :notice => 'Post was successfully created.') }
        format.json { render :json => @post, :status => :created, :location => [@post.user, @post] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT users/1/posts/1
  # PUT users/1/posts/1.json
  def update
    @user = User.friendly.find(params[:user_id])
    @post = @user.posts.friendly.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(clean_params)
        format.html { redirect_to(blogpost_path(@post), :notice => 'Post was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE users/1/posts/1
  # DELETE users/1/posts/1.json
  def destroy
    # @user = User.friendly.find(params[:user_id])
    @user = current_user
    @post = @user.posts.friendly.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_url(@user) }
      format.json { head :ok }
    end
  end

  private

  def clean_params
    params.require(:post).permit! #(:title, :content, :image_url_string,
                                 # :meta_description, :published,
                                 # :published_at, :slug, :protect_slug, :permalink_path,
                                 # :users_attributes => [:id]
                                 #  )

  end
end
