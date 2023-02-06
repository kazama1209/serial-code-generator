module ApplicationHelper
  def alert_type_to_flash_message_type(type)
    case type
    when "alert"
      "warning"
    when "notice", "success"
      "success"
    when "error", "danger"
      "danger"
    end
  end

  def icon_type_to_flash_message_type(type)
    case type
    when "notice", "success"
      "check"
    when "error", "danger"
      "ban"
    else
      type
    end
  end

  # 日付まで整形して返す
  def format_date(time)
    return time unless time

    time.strftime("%Y年%-m月%-d日")
  end

  # 分まで整形して返す
  def format_at(time)
    return time unless time

    time.strftime("%Y年%-m月%-d日 %-H時%-M分")
  end

  def items_count(arr)
    if arr.last_page?
      "#{arr.total_count} / #{arr.total_count}件"
    else
      "#{arr.size * arr.current_page} / #{arr.total_count} 件"
    end
  end
end
