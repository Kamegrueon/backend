class GamePlayer
  include ActiveModel::Model
    attr_accessor :game_name, :players, :position_ids 

  def save
    game = Game.create!(game_name: game_name)
    players.each do |player_name|
      player = Player.where(player_name: player_name).first_or_initialize
      player.save!
      GamePlayerRelation.create!(game_id: game.id, player_id: player.id)
    end
    return game
  end
end