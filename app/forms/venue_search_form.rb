class VenueSearchForm
  include ActiveModel::Model

  attr_accessor :campaign_id,
                :name

  def initialize(params = {})
    @campaign_id = params[:campaign_id]
    @name = params[:name]
  end

  def query
    base_relation
      .then(&method(:search_by_campaign_id))
      .then(&method(:search_by_name))
  end

  private

  def base_relation
    Venue.eager_load(:campaign)
  end

  # キャンペーンのIDで検索
  def search_by_campaign_id(relation)
    return relation if campaign_id.blank?

    relation.where(campaign_id: campaign_id)
  end

  # タイトルで検索
  def search_by_name(relation)
    return relation if name.blank?

    relation.where(<<-SQL, name: "%#{ActiveRecord::Base.sanitize_sql_like(name)}%")
      name LIKE :name
    SQL
  end
end
