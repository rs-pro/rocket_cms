module RocketCMS
  module Controllers
    module News
      extend ActiveSupport::Concern

      def index
        @news = model.enabled.after_now.by_date

        unless RocketCMS.configuration.news_per_page.nil?
          @news = @news.page(params[:page])
        end
      end

      def show
        @news = model.after_now.find(params[:id])
      end
      
      private
      def model
        ::News
      end
      def page_title
        if @news.class.name == model.class.name
          @news.page_title
        else
          super
        end
      end
    end
  end
end
