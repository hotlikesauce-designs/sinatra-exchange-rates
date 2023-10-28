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

get("/:first_page") do

  erb(:first_page)
end
