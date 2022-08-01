class Player < ApplicationRecord
  has_many :game_player_relations, dependent: :destroy, foreign_key: 'player_id'
  has_many :games, through: :game_player_relations
  has_many :cause_of_deaths

  validates :player_name, presence: true

  def self.assign_player_color(player_data)
    player_data = player_data.map{|p| p.attributes}.map{|x| x['roll_color'] = '#FFFFFF'; x }
    # roll_color = ['#4072EE', '#B558F6', '#FEC400', '#29CB97', '#F6679A', '#5AF2E9', '#EC4B4B', '#C2EC4B', '#EC8E4B']
    roll_color = ['#4072EE','#F44336','#8BC34A','#FFEB3B','#B558F6','#607D8B','#5AF2E9','#E91E63','#009688','#FF9800','#9F22A1','#795548','#2196F3','#FFB0B0','#9E9E9E']
    roll_count = 0

    player_data.each do |player|
      if player['roll_name'] != '人狼' && player['roll_name'] != nil
        player['roll_color'] = roll_color[roll_count]
        roll_count += 1
      end
      if player['roll_name'] == '人狼'
        player['roll_color'] = '#000000'
      end
    end
    return player_data
  end
end