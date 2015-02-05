class CreateBrowetCache < ActiveRecord::Migration
  def change
    create_table :browet_cahce do |t|
      t.string   :path, :null => false
      t.string  :params, :null => false
      t.text   :json, :null => false
      t.datetime :expire_at, :null => false
    end
    add_index :browet_cahce, [:path, :params], :unique => true
  end
end
