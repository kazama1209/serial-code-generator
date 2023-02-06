class CampaignSearchForm
  include ActiveModel::Model

  attr_accessor :title

  def initialize(params = {})
    @title = params[:title]
  end

  def query
    base_relation.then(&method(:search_by_title))
  end

  private

  def base_relation
    Campaign.all
  end

  # タイトルで検索
  def search_by_title(relation)
    return relation if title.blank?

    relation.where(<<-SQL, title: "%#{ActiveRecord::Base.sanitize_sql_like(title)}%")
      title LIKE :title
    SQL
  end
end
