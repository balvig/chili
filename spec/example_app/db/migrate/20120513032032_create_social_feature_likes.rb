# This migration comes from social_feature (originally 20120513031021)
class CreateSocialFeatureLikes < ActiveRecord::Migration
  def change
    create_table :social_feature_likes do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
