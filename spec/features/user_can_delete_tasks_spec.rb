require 'rails_helper'

feature 'User can Delete Tasks' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)

    login_as(user)

    visit task_path(task)

    click_on 'Delete'

    expect(current_path).to eq tasks_path
    expect(page).to have_content('Task Removed!')
  end

  scenario 'And Must be loged in' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)

    visit task_path(task)

    expect(current_path).to eq user_session_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end 
end
