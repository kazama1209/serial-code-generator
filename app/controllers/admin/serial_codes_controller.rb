class Admin::SerialCodesController < Admin::ApplicationController
  before_action :set_campaign, only: %i[index new]
  before_action :set_serial_code, only: %i[edit update destroy]
  
  def index
    @serial_codes = SerialCodeSearchForm.new(serial_code_search_params.merge(campaign_id: params[:campaign_id]))
                                        .query
                                        .order_by_id_desc
                                        .page(params[:page])
                                        .per(100)

    respond_to do |format|
      format.html
      format.csv do
        @serial_codes = @campaign.serial_codes.order_by_id_asc
        filename = "#{@campaign.title}_シリアルコード一覧_#{Time.now.to_i}.csv"        
        
        send_data(render_to_string, filename: filename, type: "text/csv")
      end
    end
  end

  def new
    @serial_code = SerialCode.new
  end
  
  def create
    serial_code_generate_form = SerialCodeGenerateForm.new(
      serial_code_create_params.merge(
        campaign_id: params[:campaign_id]
      )
    )
    
    success = serial_code_generate_form.run
    
    if success
      amount = serial_code_create_params[:amount].to_i
      redirect_to admin_campaign_serial_codes_path, success: "#{amount.to_s(:delimited)}件のシリアルコードを作成しました"
    else
      flash[:danger] = serial_code_generate_form.errors.full_messages.join(",")
      redirect_back(fallback_location: admin_root_path)
    end
  end

  def edit; end

  def update
    @serial_code.update!(serial_code_update_params)
    
    redirect_to admin_campaign_serial_codes_path, success: "シリアルコードを編集しました"
  end

  def destroy
    @serial_code.destroy!

    redirect_to admin_campaign_serial_codes_path, success: "シリアルコードを削除しました"
  end

  private

  def set_campaign
    @campaign = Campaign.find(params[:campaign_id])
  end
  
  def set_serial_code
    @serial_code = SerialCode.find(params[:id])
  end

  def serial_code_search_params
    params.fetch(:q, {}).permit(
      :value,
      :status,
      :expired_at
    )
  end

  def serial_code_create_params
    params.require(:serial_code).permit(
      :campaign_id,
      :amount,
      :number_of_digits,
      :format,
      :prefix,
      :expired_at
    )
  end

  def serial_code_update_params
    params.require(:serial_code).permit(
      :value,
      :status,
      :expired_at
    )
  end
end
