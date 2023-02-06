class Admin::CampaignsController < Admin::ApplicationController
  before_action :set_campaign, only: %i[edit update]

  def index
    @campaigns = CampaignSearchForm.new(campaign_search_params)
                                   .query
                                   .order_by_id_desc
                                   .page(params[:page])
                                   .per(50)
  end

  def new
    @campaign = Campaign.new
  end

  def create
    campaign = Campaign.new(campaign_params)
    campaign.save!

    redirect_to admin_campaigns_path, success: "キャンペーンを作成しました"
  end

  def edit; end

  def update
    @campaign.update!(campaign_params)

    redirect_to admin_campaigns_path, success: "キャンペーンを編集しました"
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:id])
  end

  def campaign_search_params
    params.fetch(:q, {}).permit(
      :title
    )
  end

  def campaign_params
    params.require(:campaign).permit(
      :title
    )
  end
end
