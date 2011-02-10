Given /^a url$/ do
  @shared_url = SharedUrl.create!
end

When /^I set the full url to "([^"]*)"$/ do |url|
  @shared_url.update_attribute(:full_url,url)
end

Then /^the full url should be "([^"]*)"$/ do |url|
  @shared_url.full_url.should eq(url)
end