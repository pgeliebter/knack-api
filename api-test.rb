require "dotenv/load"
require "http"
require "pg"
require "byebug"

num = 1

# 5.times do
#   response = HTTP.headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
#     .get("https://usgc-api.knack.com/v1/objects/object_#{num}/records")
#   num += 1
#   p response.parse
# end

conn = PG.connect(dbname: "movie_app_development")
conn.exec("SELECT * FROM pg_stat_activity") do |result|
  puts "     PID | User             | Query"
  result.each do |row|
    puts " %7d | %-16s | %s " %
           row.values_at("pid", "usename", "query")
  end
end
