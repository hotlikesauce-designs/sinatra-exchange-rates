require "sinatra"
require "sinatra/reloader"

require "http"
require "json"
api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

# Print the list of currencies
#currencies.each do |currency_code, currency_description|
#  puts "#{currency_code}: #{currency_description}"
#end

get("/") do
  @raw_api_data = HTTP.get(api_url)
  @parsed_api_data = JSON.parse(@raw_api_data)
  @currencies = @parsed_api_data["currencies"]
  erb(:homepage)
end

#the :colon makes it a dynamic page!
get("/:currency_from") do
  raw_api_data = HTTP.get(api_url)
  parsed_api_data = JSON.parse(raw_api_data)

  @currencies = parsed_api_data["currencies"]
  erb(:currency_from)
end

get("/:currency_from/:currency_to") do
  raw_api_data = HTTP.get(api_url)
  parsed_api_data = JSON.parse(raw_api_data)
  @currencies = parsed_api_data["currencies"]
  
  @currency_from = params.fetch("currency_from")
  @currency_to = params.fetch("currency_to")

  erb(:currency_to)
end
