class Roll < ActiveHash::Base
  include ActiveHash::Associations

  has_many :game_rolls
  has_many :games, through: :game_rolls

  self.data = [
    {id: 1, roll_name: '人狼'},
    {id: 2, roll_name: '狂人'},
    {id: 3, roll_name: '占い師'},
    {id: 4, roll_name: '霊媒師'},
    {id: 5, roll_name: '騎士'},
    {id: 6, roll_name: '妖狐'},
    {id: 7, roll_name: '共有者'},
    {id: 8, roll_name: 'ハンター'},
    {id: 9, roll_name: '独裁者'},
    {id: 10, roll_name: '狂信者'},
  ]
end
