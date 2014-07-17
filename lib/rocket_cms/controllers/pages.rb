module RocketCMS
  module Controllers
    module Pages
      extend ActiveSupport::Concern
      def show
        if @seo_page.nil? || !@seo_page.persisted?
          unless params[:id].blank?
            @seo_page = Page.enabled.find(params[:id])
          end
        end
        if @seo_page.nil?
          render_404
        end
      end
    end
  end
end

