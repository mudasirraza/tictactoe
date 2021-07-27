require 'test_helper'

class MarkerTest < ActiveSupport::TestCase
  def setup
    @game = Game.create(user: 'abc')
    @marker = @game.markers.create(user: 'abc', index_num: 1)
  end

  test "valid marker" do
    marker = @game.markers.new(user: 'def', index_num: 2)
    assert marker.valid?
  end

  test "invalid marker" do
    marker = @game.markers.new
    refute marker.valid?

    marker = @game.markers.new(user: 'abc')
    refute marker.valid?
  end

  test "valid turns" do
    marker = @game.markers.create(user: 'def', index_num: 2)
    assert marker.valid?

    marker = @game.markers.create(user: 'abc', index_num: 3)
    assert marker.valid?
  end

  test "invalid turns" do
    marker = @game.markers.create(user: 'abc', index_num: 1)
    refute marker.valid?

    err = assert_raises Exceptions::InvalidMove do
     @game.markers.create(user: 'abc', index_num: 2)
    end
    assert_match /it is player 2's turn/, err.message
  end

  test "check_winner" do
    @game.markers.create(user: 'def', index_num: 2)
    assert_nil @game.reload.winner

    @game.markers.create(user: 'abc', index_num: 4)
    assert_nil @game.reload.winner

    @game.markers.create(user: 'def', index_num: 3)
    assert_nil @game.reload.winner

    @game.markers.create(user: 'abc', index_num: 7)
    assert_equal 'abc', @game.reload.winner
  end

end
