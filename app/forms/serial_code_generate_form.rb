class SerialCodeGenerateForm
  include ActiveModel::Model
  
  attr_accessor :campaign_id,
                :amount,
                :number_of_digits,
                :format,
                :prefix,
                :expired_at

  validates :amount, serial_code_amount: true
  validates :number_of_digits, serial_code_number_of_digits: true

  def initialize(params = {})
    @campaign_id = params[:campaign_id]
    @amount = params[:amount].to_i
    @number_of_digits = params[:number_of_digits].to_i
    @format = params[:format]
    @prefix = params[:prefix]
    @expired_at = params[:expired_at]

    campaign = Campaign.find(params[:campaign_id])
    @existing_serial_code_values = campaign.serial_codes.pluck(:value)
  end

  def run
    return false if invalid?
    
    serial_codes = generate_serial_codes
    SerialCode.import!(serial_codes, batch_size: 1000)
  end

  private
  
  def generate_serial_codes
    serial_codes = []

    amount.times do
      random_chars = \
        if format == "alphanumeric"
          generate_random_alphanumerics
        else
          generate_random_numbers
        end
      
      value = "#{prefix}#{random_chars}"
      check_target_values = @existing_serial_code_values + serial_codes.pluck(:value)
      
      redo if check_target_values.include?(value)
      
      serial_code = SerialCode.new(
        campaign_id: campaign_id,
        value: value,
        expired_at: expired_at
      )

      serial_codes << serial_code      
    end

    serial_codes
  end

  def generate_random_numbers
    number_of_digits.times.map { rand(9) }.join
  end
  
  def generate_random_alphanumerics
    (0...number_of_digits).map { available_alphanumerics[rand(available_alphanumerics.length)] }.join
  end

  def available_alphanumerics
    [*"A".."Z", *"0".."9"].difference(ng_words)
  end

  def ng_words
    ["O", "0"]
  end
end
