class Marker < ApplicationRecord
  belongs_to :game

  before_save :validate_turn
  after_create :check_winner

  validates :user, :index_num, presence: true
  validates :index_num, uniqueness: { scope: [:game, :user] }

  WIN_CONDITIONS = [ [1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7] ]

  private

  def check_winner
    byebug
    winner = nil
    markers_per_users = self.game.markers.group_by(&:user)
    markers_per_users.each do |user, user_markers|
      WIN_CONDITIONS.each do |win_condition|
        if user_markers.map(&:index_num).sort == win_condition
          winner = user
          break
        end
      end
    end

    if winner.present? || self.game.markers.count >= 9
      self.game.update(status: :over, winner: winner)
    end
  end

  def validate_turn
    total_markers = self.game.markers.count
    if self.game.over?
      raise Exceptions::InvalidMove
    elsif total_markers.even? && self.game.user != self.user
      raise Exceptions::InvalidMove, "it is player 1's turn"
    elsif total_markers.odd? && self.game.user == self.user
      raise Exceptions::InvalidMove, "it is player 2's turn"
    end
  end
end
