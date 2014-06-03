class NewsController < ApplicationController
  def index
    @news = News.enabled.after_now.by_date

    unless RocketCMS.configuration.news_per_page.nil?
      @news = @news.page(params[:page])
    end
  end

  def show
    @news = News.after_now.find(params[:id])
  end
  
  private
    def page_title
      if @news.class.name == 'News'
        @news.page_title
      else
        super
      end
    end
end
