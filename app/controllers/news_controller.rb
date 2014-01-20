class NewsController < ApplicationController
  def index
    @news = News.all.page(params[:page])
  end

  def show
    @news = News.find(params[:id])
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
