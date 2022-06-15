require 'rails_helper'

feature 'User can see his Task Report' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    other_user = create(:user)
    other_profile = create(:profile, user: other_user)
    first_task = create(:task, user: user, share: true, status: 'complete', title: 'Test Task 1')
    first_comment = create(:comment, user: other_user, task: first_task)
    second_task = create(:task, user: user, share: true, status: 'complete', title: 'Test Task 2')
    second_comment = create(:comment, user: other_user, task: second_task)
    third_task = create(:task, user: user, share: true, status: 'complete', title: 'Test Task 3')
    third_comment = create(:comment, user: other_user, task: third_task)
    fourth_task = create(:task, user: user, share: true, status: 'incomplete', title: 'Test Task 4')
    fourth_comment = create(:comment, user: other_user, task: fourth_task)

    login_as(user)

    visit user_task_report_path

    expect(page).to have_content(first_task.title)
    expect(page).to have_content(second_task.title)
    expect(page).to have_content(third_task.title)
    expect(page).not_to have_content(fourth_task.title)
  end

  scenario 'And Must be loged in' do
    user = create(:user)
    profile = create(:profile, user: user)

    visit user_task_report_path

    expect(current_path).to eq user_session_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end 
end