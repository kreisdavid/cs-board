require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @post = posts(:one)
  end

  test "should get index" do
    sign_in users(:test_user)
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "not authenticated users should get redirected" do
    get :index
    assert_response :redirect
  end

  test "should get new without authentication" do
    get :new
    assert_response :success
  end

  test "should create post without authentication" do
    assert_difference('Post.count') do
      post :create, post: { approved: false,
                            title: @post.title,
                            description: @post.description,
                            expire_date: @post.expire_date,
                            offer_type: @post.offer_type, 
                            location: @post.location }
    end
    assert_redirected_to root_path
  end

  test "newly created posts are unapproved" do
    assert_difference('Post.count(:conditions => "approved == false")') do
      post :create, post: { approved: false,
                            title: @post.title,
                            description: @post.description,
                            expire_date: @post.expire_date,
                            offer_type: @post.offer_type,
                            location: @post.location }
    end
    assert_redirected_to root_path
  end

  test "should show post" do
    sign_in users(:test_user)
    get :show, id: @post.id
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:test_user)
    get :edit, id: @post.id
    assert_response :success
  end

  test "admin should update post" do
    sign_in users(:admin_user)
    patch :update, id: @post.id, post: { title: @post.title,
                                         description: @post.description,
                                         expire_date: @post.expire_date,
                                         offer_type: @post.offer_type,
                                         location: @post.location }
    assert_redirected_to post_path(assigns(:post))
  end

  test "non-admin user cannot update post" do
    sign_in users(:test_user)
    orig_title = @post.title
    patch :update, id: @post.id, post: { title: "test",
                                         description: @post.description,
                                         expire_date: @post.expire_date,
                                         offer_type: @post.offer_type,
                                         location: @post.location }
    assert_redirected_to posts_path
    assert_equal(orig_title, @post.title)
  end

  test "admin should destroy post" do
    sign_in users(:admin_user)
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end
    assert_redirected_to posts_path
  end

  test "non-admin user cannot destroy post" do
    sign_in users(:test_user)
    assert_no_difference('Post.count') do
      delete :destroy, id: @post
    end
    assert_redirected_to posts_path
  end

  test "admin should approve posts" do
    sign_in users(:admin_user)
    get :approve_posts
    assert_response :success
  end

  test "approve posts should redirect non-admins" do
    sign_in users(:test_user)
    get :approve_posts
    assert_redirected_to posts_url
  end

  test "index only includes approved and non-archived posts" do
    sign_in users(:test_user)
    get :index
    assigns(:posts).each do |p|
      assert_equal(p.approved, true)
      assert_equal(p.archived, false)
    end
  end

  test "admin should get queue of only unapproved posts" do
    sign_in users(:admin_user)
    get :approve_posts
    assigns(:posts).each do |p|
      assert_equal(p.approved, false)
    end
  end
end
