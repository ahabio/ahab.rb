Given /^the file "(.+)" does not exist$/ do |file_name|
  in_current_dir do
    FileUtils.rm_f file_name
  end
end

Given /^the URL "(.+)" returns:$/ do |url, content|
  stub_request(:get, url).with(body: content)
end

Given /^the URL "(.+)" returns a 404 error$/ do |url|
  stub_request(:get, url).with(status: 404)
end
