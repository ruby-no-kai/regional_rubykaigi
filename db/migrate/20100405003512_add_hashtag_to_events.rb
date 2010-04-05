class AddHashtagToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :hashtag, :string
  end

  def self.down
    remove_column :events, :hashtag
  end
end
