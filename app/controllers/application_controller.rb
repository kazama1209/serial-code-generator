class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :basic_auth

  def basic_auth
    if ActiveModel::Type::Boolean.new.cast(ENV["BASIC_AUTH_ENABLED"])
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["BASIC_AUTH_USERNAME"] && password == ENV["BASIC_AUTH_PASSWORD"]
      end
    end
  end
end
