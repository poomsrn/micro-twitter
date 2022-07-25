require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:test)
    @user = users(:user1)
  end

  # test "visiting the index" do
  #   visit posts_url
  #   assert_selector "h1", text: "Posts"
  # end

  # test "creating a Post" do
  #   visit posts_url
  #   click_on "New Post"

  #   fill_in "Message", with: @post.message
  #   fill_in "User", with: @post.user_id
  #   click_on "Create Post"

  #   assert_text "Post was successfully created"
  #   click_on "Back"
  # end

  # test "updating a Post" do
  #   visit posts_url
  #   click_on "Edit", match: :first

  #   fill_in "Message", with: @post.message
  #   fill_in "User", with: @post.user_id
  #   click_on "Update Post"

  #   assert_text "Post was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Post" do
  #   visit posts_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Post was successfully destroyed"
  # end

  test "like" do
      visit main_path
      fill_in "Email", with: "p1"
      fill_in "Password", with: "123"
      click_on "Login"
      @ids = @user.get_feed_post(1)
      post = Post.where(user_id: @ids).order('created_at DESC').first
      click_on "Like"
      visit "/profile/#{User.find(@post.user_id).name}"
      click_on "SEE LIKES"
      assert_text "p1"
  end

end
