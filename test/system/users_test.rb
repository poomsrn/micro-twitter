require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user1 = users(:user1) #success
    @user2 = users(:user2) #fail
  end

  # test "visiting the index" do
  #   visit users_url
  #   assert_selector "h1", text: "Users"
  # end

  # test "creating a User" do
  #   visit users_url
  #   click_on "New User"

  #   fill_in "Age", with: @user.age
  #   fill_in "Email", with: @user.email
  #   fill_in "Name", with: @user.name
  #   fill_in "Password digest", with: @user.password_digest
  #   click_on "Create User"

  #   assert_text "User was successfully created"
  #   click_on "Back"
  # end

  # test "updating a User" do
  #   visit users_url
  #   click_on "Edit", match: :first

  #   fill_in "Age", with: @user.age
  #   fill_in "Email", with: @user.email
  #   fill_in "Name", with: @user.name
  #   fill_in "Password digest", with: @user.password_digest
  #   click_on "Update User"

  #   assert_text "User was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a User" do
  #   visit users_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "User was successfully destroyed"
  # end

  test "login_fail" do
    visit main_path
    fill_in "Email", with: 'p1'
    fill_in "Password", with: '111'
    click_on "Login"
    assert_text "Email Invalid email or password !!."
  end
  test "login_success" do
    visit main_path
    fill_in "Email", with: 'p1'
    fill_in "Password", with: '123'
    click_on "Login"
    assert_text "User was successfully login."
  end


end
