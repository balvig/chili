# This migration comes from chili_likes (originally 20120513031021)
class CreateChiliLikesLikes < ActiveRecord::Migration
  def change
    create_table :chili_likes_likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
