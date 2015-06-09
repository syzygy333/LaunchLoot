require 'sinatra'
require 'csv'
require 'pry'

def random_url
  SecureRandom.urlsafe_base64(12)
end

url = random_url

def roller
  1 + rand(10)
end

get '/' do
  if roller.even?
    button1 = "/failure"
    button2 = "/#{url}"
  else
    button1 = "/#{url}"
    button2 = "/failure"
  end

  erb :index, locals: { button1: button1, button2: button2 }
end

get "/#{url}" do
  descriptor1 = CSV.read('descriptor1.csv')
  common = CSV.read('common.csv')
  rare = CSV.read('rare.csv')
  epic = CSV.read('epic.csv')
  descriptor2 = CSV.read('descriptor2.csv')

  rarity_key = { 1 => common, 2 => common, 3 => common, 4 => common, 5 => common, 6 => rare, 7 => rare, 8 => rare, 9 => epic, 10 => epic }

  color_key = { 1 => "common", 2 => "common", 3 => "common", 4 => "common", 5 => "common", 6 => "rare", 7 => "rare", 8 => "rare", 9 => "epic", 10 => "epic" }
  item_color = color_key[roller]

  chosen_noun = rarity_key[roller][0].sample
  loot = "#{descriptor1[0].sample} #{chosen_noun} of #{descriptor2[0].sample}!"

  erb :success, locals: { loot: loot, item_color: item_color }
end

get '/failure' do
  erb :failure
end



# future implementations
# • a Take It button on the success page that triggers removal from the list and redirect to home
# • randomize page names so you can't keep refreshing on 'success' without clicking the correct button
# • remove looted items (words) from CSVs for uniqueness
# • would be great if user could collect items if signed in
# and possibly equip items onto avatar
# • when launch ends, user would have to relinquish items back into the pool, but their names would get attached to the item for sense of inheritance. this would mean adding a 'legendary' rarity.
# • tailor descriptors to item rarity
