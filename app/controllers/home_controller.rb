class HomeController < ApplicationController
  def index
    render plain: "ok".freeze
  end
end
