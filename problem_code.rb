@problem_codes = JSON.parse(File.read("../../Documents/sessionproblemimportcodes.json"))
@problem_codes = @problem_codes["records"].map { |x|
  [x["field_605"], x["id"]]
}.to_h

@problem_code_object = "object_25"
