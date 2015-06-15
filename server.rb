require 'sinatra'
require 'sinatra/activerecord'
require 'csv'

# ****** new organization requires server restart to get new item *******

def random_url
  SecureRandom.urlsafe_base64(12)
end

def roller
  1 + rand(10)
end

url = random_url
roll = roller

descriptor1 = CSV.read('lootdata/descriptor1.csv')
common = CSV.read('lootdata/common.csv')
rare = CSV.read('lootdata/rare.csv')
epic = CSV.read('lootdata/epic.csv')
descriptor2 = CSV.read('lootdata/descriptor2.csv')

RARITY_KEY = { 1 => common, 2 => common, 3 => common, 4 => common, 5 => common, 6 => rare, 7 => rare, 8 => rare, 9 => epic, 10 => epic }

COLOR_KEY = { 1 => "common", 2 => "common", 3 => "common", 4 => "common", 5 => "common", 6 => "rare", 7 => "rare", 8 => "rare", 9 => "epic", 10 => "epic" }

item_color = COLOR_KEY[roll]
item_attribute_1 = descriptor1[0].sample
item_object = RARITY_KEY[roll][0].sample
item_attribute_2 = descriptor2[0].sample

get '/' do

  if roll.even?
    button1 = "/failure"
    button2 = "/#{url}"
  else
    button1 = "/#{url}"
    button2 = "/failure"
  end

  erb :index, locals: { button1: button1, button2: button2 }
end

get "/#{url}" do

  loot = "#{item_attribute_1} #{item_object} of #{item_attribute_2}!"

  erb :success, locals: { loot: loot, item_color: item_color }
end

get '/failure' do
  erb :failure
end



# future implementations
# • Take It button should trigger item's removal from the list and insertion into loot database
# • would be great if user could collect items if signed in
# and possibly equip items onto avatar
# • when launch ends, user would have to relinquish items back into the pool, but their names would get attached to the item for sense of inheritance. this would mean adding a 'legendary' rarity.
# • tailor descriptors to item rarity

# def db_connection
#   begin
#     connection = PG.connect(dbname: "korning")
#     yield(connection)
#   ensure
#     connection.close
#   end
# end
