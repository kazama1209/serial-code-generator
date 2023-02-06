require "csv"

headers = %w[
  ID
  シリアルコード
  会場
  氏名
  メールアドレス
  電話番号
  性別
  住所
  応募日時
]

rows = @applications.map do |application|
  [
    application.id,
    application.serial_code.value,
    application.venue.name,
    application.full_name,
    application.email,
    application.phone_number,
    application.gender_i18n,
    application.full_address,
    format_at(application.created_at)
  ]
end

csv_data = CSV.generate(headers: headers, write_headers: true, force_quotes: true) do |csv|
  rows.each do |row|
    csv << row
  end
end

csv_data.encode(Encoding::SJIS, invalid: :replace, undef: :replace)
