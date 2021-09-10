require "dotenv/load"
require "http"

num = 1

5.times do
  response = HTTP.headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
    .get("https://usgc-api.knack.com/v1/objects/object_#{num}/records")
  num += 1
  p response.parse
end
