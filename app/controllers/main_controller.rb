class MainController < ApplicationController
  before_filter :is_authenticated?,
    :except => :index,
    :except => :post

  def index
  end

  def post
  end
  
end
