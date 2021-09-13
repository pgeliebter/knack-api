require "dotenv/load"
require "http"
require "pg"
require "byebug"
require "csv"
require "date"

num = 1

# 5.times do
#   response = HTTP.headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
#     .get("https://usgc-api.knack.com/v1/objects/object_#{num}/records")
#   num += 1
#   p response.parse
# end

# conn = PG.connect(dbname: "movie_app_development")
# conn.exec("SELECT * FROM pg_stat_activity") do |result|
#   puts "     PID | User             | Query"
#   result.each do |row|
#     puts " %7d | %-16s | %s " %
#            row.values_at("pid", "usename", "query")
#   end
# end

table = CSV.parse(File.read("Book2.csv"), headers: true)

# table.each do |row|
#   puts row
#   sleep(1)
# end

# p table[0]["ID"].to_i

headers = ["ID", "Mandate Id", "Accounting Id", "Match Field", "Paid On", "Paid", "Updated"]
CSV.open("../../Documents/TurnaroundImport_8-7_Test_Write.csv", "w") do |csv|
  csv << headers
  CSV.foreach("../../Documents/TurnaroundImport_8-7_Test.csv", headers: true, header_converters: :symbol) do |row|
    parsed_date = Date.strptime(row[:paid_on], "%m/%d/%y")
    row[:paid_on] = parsed_date
    csv << row
  end
end

# CSV::Converters.each_pair do |name, value|
#   if value.kind_of?(Proc)
#     p [name, value.class]
#   else
#     p [name, value]
#   end
# end
