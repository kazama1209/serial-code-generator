crumb :edit_admin_user do
  link "設定", edit_admin_user_path
end

crumb :admin_campaigns do
  link "キャンペーン一覧", admin_campaigns_path
end

crumb :new_admin_campaign do
  link "キャンペーン作成", new_admin_campaign_path
  parent :admin_campaigns
end

crumb :edit_admin_campaign do |campaign|
  link "キャンペーン編集（#{campaign.title}）", edit_admin_campaign_path(campaign)
  parent :admin_campaigns
end

crumb :admin_campaign_serial_codes do |campaign|
  link "シリアルコード一覧（#{campaign.title}）", admin_campaign_serial_codes_path(campaign)
  parent :admin_campaigns
end

crumb :new_admin_campaign_serial_code do |campaign|
  link "シリアルコード作成（#{campaign.title}）", new_admin_campaign_serial_code_path(campaign)
  parent :admin_campaign_serial_codes, campaign
end

crumb :edit_admin_campaign_serial_code do |serial_code|
  link "シリアルコード編集（#{serial_code.value}）", edit_admin_campaign_serial_code_path(serial_code.campaign, serial_code)
  parent :admin_campaign_serial_codes, serial_code.campaign, serial_code
end

crumb :admin_campaign_applications do |campaign|
  link "応募一覧（#{campaign.title}）", admin_campaign_applications_path(campaign)
  parent :admin_campaigns
end

crumb :admin_campaign_venues do |campaign|
  link "会場一覧（#{campaign.title}）", admin_campaign_venues_path(campaign)
  parent :admin_campaigns
end

crumb :new_admin_campaign_venue do |campaign|
  link "会場作成（#{campaign.title}）", new_admin_campaign_venue_path(campaign)
  parent :admin_campaign_venues, campaign
end

crumb :edit_admin_campaign_venue do |venue|
  link "会場編集（#{venue.name}）", edit_admin_campaign_venue_path(venue.campaign, venue)
  parent :admin_campaign_venues, venue.campaign, venue
end
