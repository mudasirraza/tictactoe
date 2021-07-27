class Game < ApplicationRecord
  before_create :destroy_previous_games
  before_create :generate_token

  has_many :markers, dependent: :destroy

  validates :user, presence: true

  enum status: [:in_progress, :over]

  private

  def destroy_previous_games
    self.class.where(user: self.user).destroy_all
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64
    generate_token if Game.exists?(token: self.token)
  end

end
