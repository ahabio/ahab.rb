Given /^the file "(.+)" does not exist$/ do |file_name|
  in_current_dir do
    FileUtils.rm_f file_name
  end
end

Given /^the URL "(.+)" returns:$/ do |url, content|
  pending
end

Given /^the URL "(.+)" returns a 404 error$/ do |url|
  pending
end
