player_names = ['Jon', 'Jack', 'Mike', 'Noah', 'Lucas']

player_names.each do | player_name |
  Player.create!(player_name: player_name)
end