require "csv"

headers = %w[
  ID
  値
  ステータス
  作成日時
  有効期限
]

rows = @serial_codes.map do |serial_code|
  [
    serial_code.id,
    serial_code.value,
    serial_code.status_i18n,
    format_at(serial_code.created_at),
    format_date(serial_code.expired_at)
  ]
end

csv_data = CSV.generate(headers: headers, write_headers: true, force_quotes: true) do |csv|
  rows.each do |row|
    csv << row
  end
end

csv_data.encode(Encoding::SJIS, invalid: :replace, undef: :replace)
