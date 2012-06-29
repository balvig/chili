# This migration comes from social_ext (originally 20120513031021)
class CreateSocialExtLikes < ActiveRecord::Migration
  def change
    create_table :social_ext_likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
