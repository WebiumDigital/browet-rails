class CreateBrowetCache < ActiveRecord::Migration
  def change
    create_table :browet_cache do |t|
      t.string   :path, :null => false
      t.string   :locale, :null => true
      t.string  :params, :null => false
      t.text   :json, :null => false

      t.timestamps
    end
    add_index :browet_cache, [:path, :locale, :params], :unique => true
  end
end
