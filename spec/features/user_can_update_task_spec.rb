require 'rails_helper'

feature 'User can edit Tasks' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)

    login_as(user)

    visit task_path(task)

    click_on 'Edit Task'
    
    fill_in 'Task Title', with: 'Test Task 2'
    fill_in 'Description', with: 'Test Description 2'
    select 'Medium', from: 'Priority'
    select 'Complete', from: 'Status'
    select 'Public', from: 'Privacy'

    click_on 'Update Task'

    expect(current_path).to eq task_path(task)
    expect(page).to have_content('Task Updated!')
    expect(Task.last.title).to eq 'Test Task 2'
    expect(Task.last.description).to eq 'Test Description 2'
    expect(Task.last.priority).to eq 'medium'
    expect(Task.last.status).to eq 'complete'
    expect(Task.last.share).to eq true
  end 

  scenario 'And must fill all fields' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)

    login_as(user)

    visit task_path(task)

    click_on 'Edit Task'
    
    fill_in 'Task Title', with: ''
    fill_in 'Description', with: 'Test Description 2'

    click_on 'Update Task'

    expect(page).to have_content('Title is too short (minimum is 4 characters)')
  end
end
