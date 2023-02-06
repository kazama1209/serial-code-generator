class Admin::ApplicationsController < Admin::ApplicationController
  before_action :set_campaign, only: %i[index]

  def index
    @applications = ApplicationSearchForm.new(application_search_params.merge(campaign_id: params[:campaign_id]))
                                        .query
                                        .order_by_id_desc
                                        .page(params[:page])
                                        .per(100)
    

    respond_to do |format|
      format.html
      format.csv do
        @applications = @campaign.applications.order_by_id_asc
        filename = "#{@campaign.title}_応募一覧_#{Time.now.to_i}.csv"        
        
        send_data(render_to_string, filename: filename, type: "text/csv")
      end
    end
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def application_search_params
    params.fetch(:q, {}).permit(
      :serial_code_value,
      :venue_id,
      :first_name,
      :last_name,
      :email,
      :gender
    )
  end
end
