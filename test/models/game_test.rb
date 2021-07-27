require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def setup
    @game = Game.create(user: 'abc')
  end

  test "valid game" do
    game = Game.new(user: 'abc')
    assert game.valid?
  end

  test "invalid game" do
    game = Game.new
    refute game.valid?
  end

  test "destroy_previous_games" do
    Game.create(user: 'abc')
    assert_equal 1, Game.where(user: 'abc').count
  end

  test 'generate_token' do
    assert @game.token.present?
  end

  test 'game status' do
    assert_equal 'in_progress', @game.status
  end

end
