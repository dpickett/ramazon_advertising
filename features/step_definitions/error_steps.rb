Then /^I should get an error$/ do
  @error.should_not be_nil
end

Then /^the error should have a "([^\"]*)" of "([^\"]*)"$/ do |attr, value|
  @error.send(attr).should eql(value)
end

Then /^the error should have a "([^\"]*)"$/ do |attr|
  @error.send(attr).should_not be_nil
end



