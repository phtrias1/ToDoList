require 'rails_helper'

feature 'User can like comments' do 
  scenario 'And can Like a comment' do
    user = create(:user)
    create(:profile, user: user, share: true)
    task = create(:task, user: user)
    comment = create(:comment, user: user, task: task)
    login_as(user)

    visit task_path(task)
    click_on 'Plus'

    expect(comment.pluses.count).to eq 1
    expect(page).to have_content('Comment Plused')

  end

  scenario 'And can Dislike a comment' do
    user = create(:user)
    create(:profile, user: user, share: true)
    task = create(:task, user: user)
    comment = create(:comment, user: user, task: task)
    login_as(user)

    visit task_path(task)
    click_on 'Dislike'

    expect(comment.dislikes.count).to eq 1

  end


  scenario 'And can sort by most Likes' do
    pending

  end

  scenario 'And can sort by most Dislikes' do
    pending

  end
end