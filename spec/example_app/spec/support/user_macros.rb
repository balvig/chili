module UserMacros
  def login(user)
    visit new_session_path
    fill_in 'name', with: user.name
    click_button 'Log in'
  end
end
RSpec.configure { |config| config.include(UserMacros) }
