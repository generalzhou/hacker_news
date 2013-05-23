class CommentVotes < ActiveRecord::Migration
  def change

    create_table :comment_votes do |t|
      t.references :user
      t.references :comment
    end

  end
end
