require "dotenv/load"
require "http"
require "byebug"
require "csv"
require "date"
require "json"
require "ostruct"
require "./problem_code.rb"
require "addressable/uri"

# response = HTTP
#   .headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
#   .get("https://usgc-api.knack.com/v1/objects/object_6/records")

# num = 1
# 5.times do
#   response = HTTP.headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
#     .get("https://usgc-api.knack.com/v1/objects/object_#{num}/records")
#   num += 1
#   p response.parse
# end

# @problem_codes.each do |_match_field, id|
#   response = HTTP
#     .headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"], "content-type" => "application/json")
#     .put("https://usgc-api.knack.com/v1/objects/#{@problem_code_object}/records/#{id}", :json => { :field_1226 => id })
#   p response.parse(:json)
#   if response.code == 400
#     pp response
#     break
#   end
# end

# # CSV stuff
# # static headers for new csv file
# headers = ["ID", "Mandate Id", "Accounting Id", "Match Field", "Paid On", "Paid", "Import Code", "Response Code", "Updated"]
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

# this is a get request that returns a single record
filters = [{ "field" => "field_197", "operator" => "is", "value" => "2" }]
filters = JSON.generate(filters).to_s
filters = Addressable::URI.encode_component(filters)
response = HTTP
  .headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
  .get("https://usgc-api.knack.com/v1/objects/object_6/records?filters=#{filters}")
body = JSON.parse(response.body)
p session_id = body["records"][0]["id"]
