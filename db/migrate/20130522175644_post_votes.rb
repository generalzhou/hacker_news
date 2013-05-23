class PostVotes < ActiveRecord::Migration
  def change

    create_table :post_votes do |t|
      t.references :user
      t.references :post
    end
  end
end
