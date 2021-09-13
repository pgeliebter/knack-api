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

# # the below was just a test of a working put loop
# @problem_codes.each do |_match_field, id|
#   p [_match_field, id]
#   response = HTTP
#     .headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"], "content-type" => "application/json")
#   # MUST CHANGE FIELD WHEN IN LIVE APP
#     .put("https://usgc-api.knack.com/v1/objects/#{@problem_code_object}/records/#{id}", :json => { "field_1225": id, "field_1226": "now", "field_1227": DateTime.now.strftime("%m/%d/%Y %I:%M%P") })
#   p response.parse(:json)
#   if response.code != 200
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

# CSV stuff
csv_num = 1
# static headers for new csv file
headers = ["ID", "Mandate Id", "Accounting Id", "Match Field", "Paid On", "Paid", "Import Code", "Knack Id", "Response"]
# Open up the new csv file
CSV.open("TurnaroundImport_Test_Write.csv", "w") do |csv|
  # import headers into new file
  csv << headers
  # open up original csv line by line

  CSV.foreach("TurnaroundImport_9-7-21_Test.csv", headers: true, header_converters: :symbol) do |row|
    row["Import Code"] = @problem_codes[row[:match_field]]
    # this is a get request that returns a single record
    filters = [{ "field" => "field_197", "operator" => "is", "value" => row[:id] }]
    filters = JSON.generate(filters).to_s
    filters = Addressable::URI.encode_component(filters)
    response = HTTP
      .headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
      .get("https://usgc-api.knack.com/v1/objects/object_6/records?filters=#{filters}")
    body = JSON.parse(response.body)
    session_id = body["records"][0]["id"]
    p [csv_num, response.code, session_id]

    row[:knack_id] = session_id
    row[:response] = response.code

    csv << row
    if row[:paid_on]
      parsed_date = Date.strptime(row[:paid_on], "%m/%d/%y")
      row[:paid_on] = parsed_date
    end
  end
end
