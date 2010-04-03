class AddCssToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :css, :text
  end

  def self.down
    remove_column :events, :css
  end
end
