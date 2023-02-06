class ApplicationSearchForm
  include ActiveModel::Model

  attr_accessor :campaign_id,
                :serial_code_value,
                :venue_id,
                :first_name,
                :last_name,
                :email,
                :gender


  def initialize(params = {})
    @campaign_id = params[:campaign_id]
    @serial_code_value = params[:serial_code_value]
    @venue_id = params[:venue_id]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @gender = params[:gender]
  end

  def query
    base_relation
      .then(&method(:search_by_campaign_id))
      .then(&method(:search_by_serial_code_value))
      .then(&method(:search_by_venue_id))
      .then(&method(:search_by_name))
      .then(&method(:search_by_email))
      .then(&method(:search_by_gender))
  end

  private

  def base_relation
    Application.eager_load(:serial_code)
  end

  # キャンペーンのIDで検索
  def search_by_campaign_id(relation)
    return relation if campaign_id.blank?

    relation.where(campaign_id: campaign_id)
  end

  # シリアルコードの値で検索
  def search_by_serial_code_value(relation)
    return relation if serial_code_value.blank?

    relation.where(<<-SQL, serial_code_value: "%#{ActiveRecord::Base.sanitize_sql_like(serial_code_value)}%")
      serial_codes.value LIKE :serial_code_value
    SQL
  end

  # 会場のIDで検索
  def search_by_venue_id(relation)
    return relation if venue_id.blank?

    relation.where(venue_id: venue_id)
  end

  # 名前で検索 ※ 入力されたパラメータによって検索条件を変える（必ずしも姓・名どちらも入力されるとは限らないため）
  def search_by_name(relation)
    if first_name.present? && last_name.present?  # 「姓」・「名」どちらも入力
      search_by_full_name(relation)
    elsif first_name.present? && last_name.blank? # 「名」のみ入力
      search_by_first_name(relation)
    elsif first_name.blank? && last_name.present? # 「姓」のみ入力
      search_by_last_name(relation)
    else
      relation
    end
  end

  # 「フルネーム（姓名）」で検索
  def search_by_full_name(relation)
    relation
      .then(&method(:search_by_last_name))
      .then(&method(:search_by_first_name))
  end

  # 「姓」で検索
  def search_by_last_name(relation)
    relation.where(<<-SQL, last_name: "%#{ActiveRecord::Base.sanitize_sql_like(last_name)}%")
      last_name LIKE :last_name
    SQL
  end

  # 「名」で検索
  def search_by_first_name(relation)
    relation.where(<<-SQL, first_name: "%#{ActiveRecord::Base.sanitize_sql_like(first_name)}%")
      first_name LIKE :first_name
    SQL
  end
  
  # メールアドレスで検索
  def search_by_email(relation)
    return relation if email.blank?

    relation.where(<<-SQL, email: "%#{ActiveRecord::Base.sanitize_sql_like(email)}%")
      email LIKE :email
    SQL
  end

  # メールアドレスで検索
  def search_by_gender(relation)
    return relation if gender.blank?

    relation.where(gender: gender)
  end
end
