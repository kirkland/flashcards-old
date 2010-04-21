class MetaPagesController < ApplicationController
  skip_before_filter :authorized

  def about
  end

  def news
  end

end
