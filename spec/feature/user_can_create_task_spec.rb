require 'rails_helper'

feature 'User can Create Task' do
  scenario 'Successfully' do
    user = create(:user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title:', with: 'Test Task'
    fill_in 'Description:', with: 'Test Description'
    select 'Medium', from: 'Priority'
    click_on 'Create Task'

    expect(page).to have_content('Test Task')
    expect(page).to have_content('Test Description')
    expect(page).to have_content('Medium') 
  end

  scenario 'And must be loged in' do
    visit new_task_path

    expect(current_path).to eq root_path
    expect(page).not_to have_content('Create Task') 
  end

  scenario 'And Title must have more than 4 characters' do
    user = create(:user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title:', with: 'Tes'
    fill_in 'Description:', with: 'Test Description'
    select 'Medium', from: 'Priority'
    click_on 'Create Task' 

    expect(page).to have_content('Title Lenght Must be Greater than 4 characters')
  end

  scenario 'And Title must have less than 20 characters' do
    user = create(:user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title:', with: '111111111111111111111'
    fill_in 'Description:', with: 'Test Description'
    select 'Medium', from: 'Priority'
    click_on 'Create Task' 

    expect(page).to have_content('Title Lenght Must be Less than 20 characters')
  end 

  scenario 'And Description Can\'t be blank' do 
    user = create(:user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'Task Title:', with: 'Test Task'
    fill_in 'Description:', with: ''
    select 'Medium', from: 'Priority'
    click_on 'Create Task' 

    expect(page).to have_content('Description Can\'t be blank')
  end
end
