class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    # @posts = policy_scope(Post).order(position: :asc)
    @posts = Post.ordered.where(user: current_user)

    # @canonical_href = posts_url
  end
  
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @canonical_href = post_url(@post)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:notice] = "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Post #{@post.title} was successfully destroyed." }
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed." }
    end
  end

  def publish
    @post = Post.find(params[:id])

    @post.toggle!(:published)

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Post #{@post.title} was successfully #{state}." }
      format.html { redirect_to post_path(@post), notice: "Post was successfully published." }
    end
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title, 
      :subtitle,
      :body
    )
  end
end
