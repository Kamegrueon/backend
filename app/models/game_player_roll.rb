class GamePlayerRoll
  include ActiveModel::Model
  include ActiveModel::Validations
    attr_accessor :game_name, :players, :position_ids, :roll_name
  
  validates :players, presence: true

  def save
    game = Game.create!(game_name: game_name)
    players.each do |player_name|
      player = Player.where(player_name: player_name).first_or_initialize
      player.save!
      GamePlayerRelation.create!(game_id: game.id, player_id: player.id)
    end
    position_ids.each do |position_id|
      GameRoll.create!(game_id: game.id, roll_id: position_id, roll_name: Roll.find(position_id).roll_name)
    end
    Daily.create!(game_id: game.id, date_progress: 1)
    return game
  end
end