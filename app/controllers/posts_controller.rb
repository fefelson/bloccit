class PostsController < ApplicationController
  include AuthorizePost
  before_action :require_sign_in, except: :show

  def show
    @post = Post.find(params[:id])
    authorize_user(:can_show_post?)
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize_user(:can_new_post?)
  end

  def create
    @post = Post.new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    authorize_user(:can_create_post?)

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize_user(:can_edit_post?, @post)
  end

  def update
    @post = Post.find(params[:id])
    authorize_user(:can_update_post?, @post)
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated"
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize_user(:can_destroy_post?, @post)

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully"
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post"
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
