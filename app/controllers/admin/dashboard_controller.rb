class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PASS']

  def show
    @product_count = Product.count
    @categories_count = Category.count
  end
end
