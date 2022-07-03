class GamePlayerRole
  include ActiveModel::Model
  include ActiveModel::Validations
    attr_accessor :game_name, :players, :position_ids 
  
  validates :players, presence: true

  def save
    game = Game.create!(game_name: game_name)
    players.each do |player_name|
      player = Player.where(player_name: player_name).first_or_initialize
      player.save!
      GamePlayerRelation.create!(game_id: game.id, player_id: player.id)
    end
    position_ids.each do |position_id|
      GameRole.create!(game_id: game.id, role_id: position_id)
    end
    Daily.create!(game_id: game.id, date_progress: 1)
    return game
  end
end