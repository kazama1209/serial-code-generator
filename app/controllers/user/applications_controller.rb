class User::ApplicationsController < User::ApplicationController
  before_action :set_campaign, only: %i[create complete]
  
  def create
    serial_code = SerialCode.find_by(value: params[:serial_code_value])

    if serial_code.nil?
      @application = Application.new(application_params)
      @application.errors.add(:base, "入力されたシリアルコードに誤りがあります")

      return render "user/campaigns/show"
    end

    @application = Application.new(
      application_params.merge(
        campaign_id: params[:campaign_id],
        serial_code_id: serial_code.id
      )
    )

    if @application.save
      @application.serial_code.update!(status: :applied)
      
      redirect_to complete_campaign_applications_path(@campaign)
    else
      render "user/campaigns/show"
    end
  end

  def complete; end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end

  def application_params    
    params.require(:application).permit(
      :venue_id,
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :gender,
      :birthdate,
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building
    )
  end
end
