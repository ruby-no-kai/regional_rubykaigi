class AddSynonymsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :synonyms, :string
  end

  def self.down
    remove_column :events, :synonyms
  end
end
