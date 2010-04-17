require 'test_helper'

class CardSoundsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:card_sounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create card_sound" do
    assert_difference('CardSound.count') do
      post :create, :card_sound => { }
    end

    assert_redirected_to card_sound_path(assigns(:card_sound))
  end

  test "should show card_sound" do
    get :show, :id => card_sounds(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => card_sounds(:one).id
    assert_response :success
  end

  test "should update card_sound" do
    put :update, :id => card_sounds(:one).id, :card_sound => { }
    assert_redirected_to card_sound_path(assigns(:card_sound))
  end

  test "should destroy card_sound" do
    assert_difference('CardSound.count', -1) do
      delete :destroy, :id => card_sounds(:one).id
    end

    assert_redirected_to card_sounds_path
  end
end
