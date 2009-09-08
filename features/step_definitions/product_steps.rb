When /^I try to find the asin "([^\"]*)"$/ do |asin|
  @products = Ramazon::Product.find(:item_id => asin, :response_group => "Medium")
  @product = @products[0]
end

Given /^I am searching with the "([^\"]*)" of "([^\"]*)"$/ do |attr, value|
  @search_options ||= {}
  @search_options[attr] = value
end

When /^I perform the product search$/ do
  begin
    @search_options ||= {}
    @products = Ramazon::Product.find(@search_options)
  rescue Ramazon::Error => e
    @error = e
  end
end

Then /^I should get a list of products$/ do
  raise @error if @error
  @products.should_not be_empty
end

Then /^the list of products should have more than (\d+) product$/ do |count|
  @products.should have_at_least(count.to_i + 1).items
end


Then /^each product should have the "([^\"]*)" "([^\"]*)"$/ do |attr, value|
  @products.each do |p|
    p.send(attr).should eql(value)
  end
end

Then /^I should get a product$/ do
  raise @error if @error
  @product.should_not be_nil
end

Then /^the product should have the "([^\"]*)" "([^\"]*)"$/ do |attr, value|
  @product.send(attr).should eql(value)
end

Then /^the product should have a "([^\"]*)"$/ do |attr|
  @product.send(attr).should_not be_nil
end

