class GameSerializer < ActiveModel::Serializer
  attributes :id, :status, :user, :winner, :token, :markers

  def markers
    object.markers.map{ |m| [ m.index_num, m.user ] }.to_h
  end
end
