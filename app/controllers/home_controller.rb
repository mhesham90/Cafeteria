class HomeController < ApplicationController
  def index

      @products = Product.all
      @categories = Category.all
      @latestorders=current_user.orders.last

  end
end
