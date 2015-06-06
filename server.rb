require 'sinatra'
require 'csv'
require 'pry'

get '/' do
  button_roll = 1 + rand(10)

  if button_roll.even?
    button1 = "/failure"
    button2 = "/success"
  else
    button1 = "/success"
    button2 = "/failure"
  end

  erb :index, locals: { button1: button1, button2: button2 }
end

get '/success' do
  loot_roll = 1 + rand(10)

  descriptor1 = CSV.read('descriptor1.csv')
  common = CSV.read('common.csv')
  rare = CSV.read('rare.csv')
  epic = CSV.read('epic.csv')
  descriptor2 = CSV.read('descriptor2.csv')

  rarity_key = { 1 => common, 2 => common, 3 => common, 4 => rare, 5 => rare, 6 => rare, 7 => rare, 8 => rare, 9 => rare, 10 => epic }

  color_key = { 1 => "common", 2 => "common", 3 => "common", 4 => "rare", 5 => "rare", 6 => "rare", 7 => "rare", 8 => "rare", 9 => "rare", 10 => "epic" }
  item_color = color_key[loot_roll]

  chosen_noun = rarity_key[loot_roll][0].sample
  loot = "#{descriptor1[0].sample} #{chosen_noun} of #{descriptor2[0].sample}!"

  erb :success, locals: { loot: loot, item_color: item_color }
end

get '/failure' do
  erb :failure
end

# different colors on text to indicate rarity
# buttons to roll to open chest

# future implementations
# • remove looted items (words) from CSVs for uniqueness
# • would be great if user could collect items if signed in
# and possibly equip items onto avatar
# • when launch ends, user would have to relinquish items back into the pool,
#   but their names would get attached to the item for sense of inheritance
# • tailor descriptors to item rarity
