module Api
  module V1
    class GamesController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @game = Game.where(user: current_user).last
        @game = Game.create(user: current_user) if @game.blank? || @game.over?

        if @game.valid?
          render json: @game
        else
          render json: { error: @game.errors.messages }, status: :unprocessable_entity
        end
      end

      def new
        @game = Game.create(user: current_user)
        session.delete 'token'
        render json: @game
      end

      def show
        @game = Game.find_by_token(params[:token])

        if @game.present?
          session[:token] = params[:token]
          render json: @game
        else
          render json: { error: 'The game is not valid' }, status: 404
        end
      end

      def mark
        marker = current_game.markers.create(marker_params.merge(user: current_user))
      rescue Exceptions::InvalidMove => e
        render json: { error: e.message }, status: :unprocessable_entity
      else
        ActionCable.server.broadcast 'games_channel', game: GameSerializer.new(current_game).as_json
      end

      private

        def marker_params
          params.require(:marker).permit(:index_num)
        end

    end

  end
end
