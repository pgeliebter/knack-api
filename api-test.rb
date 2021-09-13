require "dotenv/load"
require "http"
require "byebug"
require "csv"
require "date"
require "json"
require "ostruct"
require "./problem_code.rb"

# num = 1
# 5.times do
#   response = HTTP.headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
#     .get("https://usgc-api.knack.com/v1/objects/object_#{num}/records")
#   num += 1
#   p response.parse
# end

# response = HTTP
#   .headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
#   .put("https://api.knack.com/v1/objects/#{@problem_code_object}/records/record_ID")

# # CSV stuff
# # static headers for new csv file
# headers = ["ID", "Mandate Id", "Accounting Id", "Match Field", "Paid On", "Paid", "Import Code", "Updated"]
# # Open up the new csv file
# CSV.open("../../Documents/TurnaroundImport_8-7_Test_Write.csv", "w") do |csv|
#   # import headers into new file
#   csv << headers
#   # open up original csv line by line
#   CSV.foreach("../../Documents/TurnaroundImport_8-7.csv", headers: true, header_converters: :symbol) do |row|
#     row["Import Code"] = @problem_codes[row[:match_field]]
#     row[:updated] = "Yes"
#     if row[:paid_on]
#       parsed_date = Date.strptime(row[:paid_on], "%m/%d/%y")
#       row[:paid_on] = parsed_date
#     end

#     csv << row
#   end
# end
