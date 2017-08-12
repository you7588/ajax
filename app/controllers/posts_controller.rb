class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    @posts = Post.order("id DESC").all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

  end

  def destroy
    @post = current_user.posts.find(params[:id]) # 只能删除自己的贴文
    @post.destroy

  end

  def like
    @post = Post.find(params[:id])
    unless @post.find_like(current_user)
        Like.create( :user => current_user, :post => @post)
    end

    redirect_to posts_path
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    redirect_to posts_path
  end

  protected

  def post_params
    params.require(:post).permit(:content)
   end

  end
