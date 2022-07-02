player_ids = 'Jon Jack Mike Noah Lucas'

game = Game.create!(game_name: 'first_game')
player_list = player_ids.split(/[[:blank:]]+/).select(&:present?)
player_list.each do |player_name|
  player = Player.where(player_name: player_name).first_or_initialize
  player.save
  GamePlayerRelation.create!(game_id: game.id, player_id: player.id)
end