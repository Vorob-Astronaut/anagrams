class AddAvatarsToTitle < ActiveRecord::Migration
  def self.up
    change_table :titles do |t|
      t.attachment :keyArt
    end
  end

  def self.down
    drop_attached_file :titles, :keyArt
  end
end
