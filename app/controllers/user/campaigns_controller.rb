class User::CampaignsController < User::ApplicationController
  def show
    @campaign = Campaign.find(params[:id])
    @application = Application.new
  end
end
