class TrackingController < ApplicationController
  def index
    require '/Users/hugoyuanhu/RubymineProjects/mailcorgi_rails/api/shipping/imb/tracking/curl.rb'
    @token = IMBtracking.getToken(ENV['usps_username'], ENV['usps_password'])
    @data = IMBtracking.trackByIMB(@token, params[:id])
  end
end
