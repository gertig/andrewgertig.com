class PostsController < ApplicationController
  # GET users/1/posts
  # GET users/1/posts.json
  
  before_filter :find_post

  def find_post
    @post = Post.find(params[:id])

    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    if request.path != blogpost_path(@post)
      return redirect_to blogpost_path(@post), :status => :moved_permanently
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  # GET users/1/posts/1
  # GET users/1/posts/1.json
  def show
    # @user = User.find(params[:user_id])
    # @post = @user.posts.find(params[:id])
    @post = Post.find_by_slug(params[:id])
    @user = @post.user

    respond_to do |format|
      # if !@post.nil?
        format.html # show.html.erb
        format.json { render :json => @post }
      # end
    end
  end

  # GET users/1/posts/new
  # GET users/1/posts/new.json
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET users/1/posts/1/edit
  def edit
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  # POST users/1/posts
  # POST users/1/posts.json
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to([@post.user, @post], :notice => 'Post was successfully created.') }
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
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
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
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_url(user) }
      format.json { head :ok }
    end
  end
end
