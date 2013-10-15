require 'spec_helper'

feature 'View overrides' do
  scenario 'when user is not admin active_if toggles overrides off' do
    login User.create!(admin: false)
    visit '/posts'
    page.should_not have_content('See Your Likes')
    page.should_not have_content('Like functionality is in beta')
  end

  scenario 'when admin active_if toggles overrides on' do
    login User.create!(admin: true)
    visit '/posts'
    page.should have_content('See Your Likes')
  end
end

feature 'Togglable controllers' do
  scenario 'when user is not admin active_if hides controllers in feature' do
    login User.create!(admin: false)
    visit '/chili/social_feature/likes'
    #expect { visit('/chili/social_feature/likes') }.to raise_error(ActionController::RoutingError)
  end

  scenario 'when admin active_if makes controllers available' do
    login User.create!(admin: true)
    visit '/chili/social_feature/likes'
    page.should have_content('Your Likes')
  end
end

feature 'Multiple chili features' do
  scenario 'multiple overrides do not redefine each other' do
    login User.create!(admin: true)
    visit '/posts'
    page.should have_content('Like functionality is in beta')
    page.should have_content('Invite functionality is also in beta')
  end

  scenario 'Chili works alongside permanent spree overrides' do
    visit '/posts'
    page.should have_content('Permanent spree override')
  end
end
