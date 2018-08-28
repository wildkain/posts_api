module Api
  module V1
    class PostsController < ApplicationController
      respond_to :json

      def index
        @posts = Post.order(published_at: :desc)
        response.headers["page"] = 2
        response.headers["posts_count"]  = @posts.count
        respond_with @posts
      end

      def show
        @post = Post.find(params[:id])
        respond_with @post
      end

      def create
        @post = current_user.posts.create(post_params)
        respond_with :api, :v1, @post
      end

      private

      def post_params
        params.require(:post).permit(:title, :body, :published_at)
      end

    end
  end
end
