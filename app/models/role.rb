class Role < ActiveHash::Base
  include ActiveHash::Associations

  has_many :game_roles
  has_many :games, through: :game_roles

  self.data = [
    {id: 1, role_name: '人狼'},
    {id: 2, role_name: '狂人'},
    {id: 3, role_name: '占い師'},
    {id: 4, role_name: '霊媒師'},
    {id: 5, role_name: '騎士'},
    {id: 6, role_name: '妖狐'},
    {id: 7, role_name: '共有者'},
    {id: 8, role_name: 'ハンター'},
    {id: 9, role_name: '独裁者'},
    {id: 10, role_name: '狂信者'},
  ]
end
