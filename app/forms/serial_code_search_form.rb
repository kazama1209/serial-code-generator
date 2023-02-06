class SerialCodeSearchForm
  include ActiveModel::Model

  attr_accessor :campaign_id,
                :value,
                :status,
                :expired_at

  def initialize(params = {})
    @campaign_id = params[:campaign_id]
    @value = params[:value]
    @status = params[:status]
    @expired_at = params[:expired_at]
  end

  def query
    base_relation
      .then(&method(:search_by_campaign_id))
      .then(&method(:search_by_value))
      .then(&method(:search_by_status))
      .then(&method(:search_by_expired_at))
  end

  private

  def base_relation
    SerialCode.eager_load(:campaign)
  end

  # キャンペーンのIDで検索
  def search_by_campaign_id(relation)
    return relation if campaign_id.blank?

    relation.where(campaign_id: campaign_id)
  end

  # 値で検索
  def search_by_value(relation)
    return relation if value.blank?

    relation.where(<<-SQL, value: "%#{ActiveRecord::Base.sanitize_sql_like(value)}%")
      value LIKE :value
    SQL
  end

  # ステータスで検索
  def search_by_status(relation)
    return relation if status.blank?

    relation.where(status: status)
  end

  # 有効期限で検索
  def search_by_expired_at(relation)
    return relation if expired_at.blank?

    relation.where(expired_at: expired_at)
  end
end
