require "spec_helper"

feature "Add comments from content" do
  before do
    user = build :user
    user.permissions = [User::Permissions::SIGNIN, User::Permissions::GDS_EDITOR]
    user.save
  end

  scenario "add comment from content" do
    content = create :content

    visit content_path(content)
    comment_text = "Test comment"
    fill_in "comment_message", with: comment_text
    click_on "Create Comment"

    current_path.should eq(content_path(content))
    page.should have_text(comment_text)
  end
end