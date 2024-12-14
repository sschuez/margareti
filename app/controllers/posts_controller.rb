class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_post, only: %i[show edit update destroy publish shift save_content]

  def index
    @user = User.find(params[:user_id])
    @posts = policy_scope(Post).ordered.where(user: @user)

    index_meta_tags(@user)
    # @canonical_href = posts_url
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
    authorize @post
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    authorize @post

    if @post.save
      redirect_to post_path(@post), notice: 'Post created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize @post

    show_meta_tags(@post)
    # @canonical_href = post_url(@post)
  end

  def edit
    authorize @post
  end

  def update
    authorize @post

    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:notice] = 'Post updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post

    @post.destroy

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Post #{@post.title} destroyed" }
      format.html { redirect_to user_posts_path(@post.user), notice: 'Post destroyed' }
    end
  end

  def publish
    authorize @post, :update?

    @post.toggle!(:published)
    state = @post.published? ? 'published' : 'unpublished'

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Post #{@post.title} #{state}" }
      format.html { redirect_to post_path(@post), notice: "Post #{state}" }
    end
  end

  def shift
    authorize @post, :update?

    @post.shift(params[:direction])

    redirect_to user_posts_path(current_user)
  end

  def save_content
    authorize @post, :update?

    if @post.update(body: params[:content])
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = 'Post content saved' }
        format.html { redirect_to edit_post_path(@post), notice: 'Post content saved' }
      end
    else
      render :edit, status: :unprocessable_entity
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

  def index_meta_tags(user)
    set_meta_tags title: "#{user.name}'s posts",
                  description: user.posts.any? ? user.posts.map(&:title).join(', ') : 'A space to blog about your work and your ideas',
                  keywords: 'portfolio, ideas, projects, showcase, work, blog, article',
                  og: {
                    title: "#{user.name}'s posts",
                    description: user.posts.any? ? user.posts.map(&:title).join(', ') : 'A space to blog about your work and your ideas',
                    type: 'website',
                    url: user_posts_url(user),
                    image: user.photo.attached? ? url_for(user.photo) : nil
                  },
                  twitter: {
                    card: 'summary',
                    site: '@yourportfolio',
                    title: "#{user.name}'s posts",
                    description: user.posts.any? ? user.posts.map(&:title).join(', ') : 'A space to blog about your work and your ideas',
                    image: user.photo.attached? ? url_for(user.photo) : nil
                  }
  end

  def show_meta_tags(post)
    set_meta_tags title: post.title,
                  description: post.subtitle.presence || post.body.truncate(300),
                  keywords: post.keywords,
                  og: {
                    title: post.title,
                    description: post.subtitle.presence || post.body.truncate(300),
                    type: 'website',
                    url: post_url(post),
                    image: post.user.photo.attached? ? url_for(post.user.photo) : nil
                  },
                  twitter: {
                    card: 'summary',
                    site: '@yourportfolio',
                    title: post.title,
                    description: post.subtitle.presence || post.body.truncate(300),
                    image: post.user.photo.attached? ? url_for(post.user.photo) : nil
                  }
  end
end
