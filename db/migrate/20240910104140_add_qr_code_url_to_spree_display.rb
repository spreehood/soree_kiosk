class AddQrCodeUrlToSpreeDisplay < ActiveRecord::Migration[7.1]
  def self.up
    add_column :spree_displays, :qr_code_url, :string
  end

  def self.down
    remove_column :spree_displays, :qr_code_url
  end
end
