class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :user
      t.references :post
      t.timestamps
    end
  end
end
