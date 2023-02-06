class Admin::VenuesController < Admin::ApplicationController
  before_action :set_campaign, only: %i[index new]
  before_action :set_venue, only: %i[edit update destroy]

  def index
    @venues = VenueSearchForm.new(venue_search_params)
                             .query
                             .order_by_id_desc
                             .page(params[:page])
                             .per(50)
  end

  def new
    @venue = Venue.new
  end

  def create
    venue = Venue.new(venue_params)
    venue.save!

    redirect_to admin_campaign_venues_path, success: "会場を作成しました"
  end

  def edit; end

  def update
    @venue.update!(venue_params)

    redirect_to admin_campaign_venues_path, success: "会場を編集しました"
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_search_params
    params.fetch(:q, {}).permit(
      :name
    ).merge(campaign_id: params[:campaign_id])
  end

  def venue_params
    params.require(:venue).permit(
      :name
    ).merge(campaign_id: params[:campaign_id])
  end
end
