class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    # @posts = policy_scope(Post).order(position: :asc)
    @user = User.find(params[:user_id])
    @posts = Post.ordered.where(user: @user)

    # @canonical_href = posts_url
  end
  
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: 'Post created'
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
      flash[:notice] = "Post updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Post #{@post.title} destroyed" }
      format.html { redirect_to user_posts_path(@post.user), notice: "Post destroyed" }
    end
  end

  def publish
    @post = Post.find(params[:id])

    @post.toggle!(:published)
    state = @post.published? ? "published" : "unpublished"

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Post #{@post.title} #{state}" }
      format.html { redirect_to post_path(@post), notice: "Post #{state}" }
    end
  end

  def order
    @post = Post.find(params[:id])
    @post.insert_at(params[:new_position])
    
    head :no_content
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
