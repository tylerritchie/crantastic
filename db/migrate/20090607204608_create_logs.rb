class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :log do |t|
      t.string :message, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :log
  end
end
