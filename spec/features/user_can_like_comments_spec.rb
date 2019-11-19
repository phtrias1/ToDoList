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
    click_on 'Minus'

    expect(comment.minuses.count).to eq 1

  end


  scenario 'And can sort by most Likes' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    most_liked_comment = create(:comment, user: user, task: task)
    least_liked_comment = create(:comment, user: user, task: task)
    create(:pluse, user: user, comment: most_liked_comment)
    create(:pluse, user: user, comment: most_liked_comment)
    create(:pluse, user: user, comment: most_liked_comment)
    create(:pluse, user: user, comment: least_liked_comment)

    visit task_path(task)
    click_on 'Most Pluses'

    most_liked_comment.body.should appear_before(least_liked_comment.body)

  end

  scenario 'And can sort by most Dislikes' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    most_liked_comment = create(:comment, user: user, task: task)
    least_liked_comment = create(:comment, user: user, task: task)

    visit task_path(task)
    click_on 'Most Minuses'

    most_liked_comment.body.should appear_before(least_liked_comment.body)

  end

  scenario 'And can sort by most General Votes' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    most_liked_comment = create(:comment, user: user, task: task)
    least_liked_comment = create(:comment, user: user, task: task)

    visit task_path(task)
    click_on 'Most Total'

    most_liked_comment.body.should appear_before(least_liked_comment.body)

  end
end
