require 'spec_helper'

feature 'View overrides' do
  scenario 'when user is not admin active_if toggles overrides off' do
    User.create!
    visit('/posts')
    page.should_not have_content('See Your Likes')
    page.should_not have_content('Like functionality is in beta')
  end

  scenario 'when admin active_if toggles overrides on' do
    User.create!(admin: true)
    visit('/posts')
    page.should have_content('See Your Likes')
  end
end

feature 'Togglable controllers' do
  scenario 'when user is not admin active_if hides engine controller' do
    User.create!
    expect { visit('/chili/social_extension/likes') }.to raise_error(ActionController::RoutingError)
  end

  scenario 'when admin active_if toggles overrides on' do
    User.create!(admin: true)
    visit('/chili/social_extension/likes')
    page.should have_content('Your Likes')
  end
end

feature 'Multiple chili extensions' do
  scenario 'multiple overrides do not redefine each other' do
    User.create!(admin: true)
    visit('/posts')
    page.should have_content('Like functionality is in beta')
    page.should have_content('Invite functionality is also in beta')
  end
end
