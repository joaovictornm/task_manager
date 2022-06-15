require 'rails_helper'

feature 'User can view public tasks in Task Board' do
  scenario 'Sucessfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user, share: true, title: 'Test Task 1')
    second_task = create(:task, user: user, share: true, title: 'Test Task 2')
    third_task = create(:task, user: user, share: true, title: 'Test Task 3')
    fourth_task = create(:task, user: user, share: false, title: 'Test Task 4')
    login_as(user)

    visit tasks_path

    expect(page).to have_content(first_task.title)
    expect(page).to have_content(second_task.title)
    expect(page).to have_content(third_task.title)
    expect(page).not_to have_content(fourth_task.title)

  end
end
