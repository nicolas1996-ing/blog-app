class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # This is a helper method that will be available to all controller actions, 
  # only set for edit action ( you can set this for the other actions )
  before_action :set_blog_post, only: [:edit] 
  # before_action :set_blog_post, except: [:index, :new, :create]

  def index 
    @blog_posts = BlogPost.all
  end

  def show 
    @blog_post = set_blog_post
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new 
    # devise method to check if user is signed in
    @blog_post = BlogPost.new
  end

  def create 
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit 
  end

  def update
    @blog_post = set_blog_post
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    set_blog_post.destroy!
    redirect_to root_path
  end

  private 

  def set_blog_post 
    @blog_post ||= BlogPost.find(params[:id]) 
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  # devise include this method for default
  # def authenticate_user!
  #   redirect_to new_user_session_path, alert: "you must sign in or sign up to continue." unless user_signed_in?  
  # end
  
end
