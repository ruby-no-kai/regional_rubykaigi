class AddRedirectToExternalAndRedirectUrlToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :redirect_to_external, :boolean, :null => false, :default => false
    add_column :events, :redirect_url, :string
  end

  def self.down
    remove_column :events, :redirect_url
    remove_column :events, :redirect_to_external
  end
end
