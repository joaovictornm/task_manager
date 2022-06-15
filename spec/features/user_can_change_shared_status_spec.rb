require 'rails_helper'

feature 'User can change shared status' do
  scenario 'When creating a task to true' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title', with: 'Test Task'
    fill_in 'Description', with: 'Test Description'
    select 'Medium', from: 'Priority'
    select 'Public', from: 'Privacy' 
    click_on 'Create Task'

    expect(Task.last.share).to eq true 
  end

  scenario 'When creating a task to false' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title', with: 'Test Task'
    fill_in 'Description', with: 'Test Description'
    select 'Medium', from: 'Priority'
    select 'Private', from: 'Privacy' 
    click_on 'Create Task'

    expect(Task.last.share).to eq false 

  end

  scenario 'On edit page to true' do 
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    visit task_path(task)
    click_on 'Edit Task'

    fill_in 'Task Title', with: 'Test Task'
    fill_in 'Description', with: 'Test Description'
    select 'High', from: 'Priority'
    select 'Public', from: 'Privacy' 
    click_on 'Update Task' 

    expect(Task.last.share).to eq true 
  end

  scenario  'On edit page to false' do 
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    visit task_path(task)
    click_on 'Edit Task'

    fill_in 'Task Title', with: 'Test Task'
    fill_in 'Description', with: 'Test Description'
    select 'High', from: 'Priority'
    select 'Private', from: 'Privacy' 
    click_on 'Update Task'

    expect(Task.last.share).to eq false 
  end 

  scenario 'And can edit on show page(Incomplete to Complete)' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user, share: true, title: 'Test Task', description: 'Test Description')
    login_as(user)

    visit root_path
    click_on 'Task Board'
    visit task_path(task)
    select 'Complete', from: 'Change Status:'
    click_on 'Change Setting'

    expect(page).to have_content('This Task is Complete')
  end

  scenario 'And can edit on show page(Complete to Incomplete)' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user, share: true, title: 'Test Task', description: 'Test Description')
    login_as(user)

    visit root_path
    click_on 'Task Board'
    visit task_path(task)
    select 'Incomplete', from: 'Change Status:'
    click_on 'Change Setting'

    expect(page).to have_content('This Task is Incomplete')
  end

  end
