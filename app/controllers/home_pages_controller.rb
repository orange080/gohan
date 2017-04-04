class HomePagesController < ApplicationController
  def home
    if params[:p]
      redirect_to controller: 'search', action: 'index'
    end
  end
end

