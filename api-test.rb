require "dotenv/load"
require "http"
require "byebug"
require "csv"
require "date"

# num = 1
# 5.times do
#   response = HTTP.headers("X-Knack-Application-Id" => ENV["KNACK_APP_ID"], "X-Knack-REST-API-KEY" => ENV["KNACK_API_KEY"])
#     .get("https://usgc-api.knack.com/v1/objects/object_#{num}/records")
#   num += 1
#   p response.parse
# end

headers = ["ID", "Mandate Id", "Accounting Id", "Match Field", "Paid On", "Paid", "Updated"]
CSV.open("../../Documents/TurnaroundImport_8-7_Test_Write.csv", "w") do |csv|
  csv << headers
  CSV.foreach("../../Documents/TurnaroundImport_8-7.csv", headers: true, header_converters: :symbol) do |row|

    # p row[:paid_on], row[:id]
    if row[:paid_on]
      parsed_date = Date.strptime(row[:paid_on], "%m/%d/%y")
      row[:paid_on] = parsed_date
    end
    csv << row
  end
end
