class AddBannerLinkToAds < ActiveRecord::Migration
  def change
    add_column :ads, :link_url, :string, null: false, default: 'https://miss-suzuki.com'
  end
end
