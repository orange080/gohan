class SearchController < ApplicationController

  def index
      # recipeid = params[:p]
      # パラメータを取得する（例 : お肉）
      # category_id = params[:category_id]
      
      # (10) → 肉
      # 本当はここを自由変えられるようにする
      
      @category_id = params[:p]
      response = RakutenWebService::Recipe.ranking(@category_id)
      @recipes = response.first(10)

      # ぐるなび API を呼ぶ（仮です）

      # 後ほど必ず環境変数で渡すこと

      # API をコールしています
      # 右側にあるハッシュはパラメータです
      # 以下の URL を参考にして，パラメータを詳細化しましょう
      # http://api.gnavi.co.jp/api/manual/restsearch/
      case params[:p]
        when "10" then
          gurunabiword = "肉"
        when "11" then
          gurunabiword = "魚"
        when "12" then
          gurunabiword = "野菜"
        when "14" then
          gurunabiword = "寿司"
        when "16" then
          gurunabiword = "ラーメン"
        when "22" then
          gurunabiword = "パン"
        when "23" then
          gurunabiword = "鍋"
        when "41" then
          gurunabiword = "中華料理"
        when "42" then
          gurunabiword = "韓国料理"
        when "43" then
          gurunabiword = "フランス料理"
        when "46" then
          gurunabiword = "エスニック料理"
        when "47" then
          gurunabiword = "沖縄料理"
        end
        
      res = Faraday.get 'https://api.gnavi.co.jp/RestSearchAPI/20150630/', { 
        keyid: Rails.application.secrets.key_id, 
        format: 'json', 
        pref: 'PREF13',
        buffet: 1 ,
        freeword: gurunabiword,
        hit_per_page: 5 ,
      }
      
      # res = Faraday.get 'https://api.gnavi.co.jp/RestSearchAPI/20150630/', { keyid: Rails.application.secrets.key_id, format: 'json', buffet: 1 }

      # API をコールした結果が入ってくるので，ここを加工する必要があります
      # ドキュメントにも書いてありますが，rest というパラメータの中に店情報が複数入ってます
      # よって body['rest'] という書き方ができます
      body = JSON.parse(res.body)
      # a = body.dig("rest",0)
      @restaurants = body['rest']
  end

end
