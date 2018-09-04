module Api
  module V1
    class PostsController < ApiApplicationController
      respond_to :json

      def index
        if (params[:page] && params[:per_page]) && params[:per_page].to_i > 0
          @posts = Post.order(published_at: :desc).paginate(page: params[:page], per_page: params[:per_page])
          prepare_headers
        else
          @posts = Post.order(published_at: :desc)
        end
        render json: @posts
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

      def prepare_headers
        response.headers['total_pages'] = Post.count / params[:per_page].to_i
        response.headers['total_posts'] = Post.count
      end
    end
  end
end
