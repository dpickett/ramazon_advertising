Given /^I have a valid access key$/ do
  configatron.ramazon.access_key.should_not be_nil
end

Given /^I have a valid secret key$/ do
  configatron.ramazon.secret_key.should_not be_nil
end

