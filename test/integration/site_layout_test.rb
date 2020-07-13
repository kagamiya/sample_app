require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    # when logged in
    log_in_as(@user)
    assert_redirected_to @user
    follow_redirect!
    assert_select "a[href=?]", login_path, count:0
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    # when logged out
    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", users_path,            count:0
    assert_select "a[href=?]", user_path(@user),      count:0
    assert_select "a[href=?]", edit_user_path(@user), count:0
    assert_select "a[href=?]", logout_path,           count:0
  end
  
  test "correct title" do
    get root_path
    assert_select "title", full_title("")
    get contact_path
    assert_select "title", full_title("Contact")
  end
end
