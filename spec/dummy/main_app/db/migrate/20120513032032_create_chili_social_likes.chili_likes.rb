# This migration comes from chili_social (originally 20120513031021)
class CreateChiliSocialLikes < ActiveRecord::Migration
  def change
    create_table :chili_social_likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
