class NewsController < ApplicationController
  def index
    @news = News.after_now.page(params[:page])
    p @news
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
