class SearchController < ApplicationController

  def index
      # recipeid = params[:p]
      # パラメータを取得する（例 : お肉）
      # category_id = params[:category_id]
      
      # (10) → 肉
      # 本当はここを自由変えられるようにする
      response = RakutenWebService::Recipe.ranking(params[:p])
      @recipes = response.first(10)
  end

end
