# This migration comes from social_extension (originally 20120513031021)
class CreateSocialExtensionLikes < ActiveRecord::Migration
  def change
    create_table :social_extension_likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
