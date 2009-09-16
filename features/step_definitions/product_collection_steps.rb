Then /^the list of products should have "([^\"]*)"$/ do |attr|
  @products.send(attr).should_not be_nil
  if @products.respond_to?(:empty?)
    @products.should_not be_empty
  end
end

Then /^each "([^\"]*)" in the list of products should have "([^\"]*)"$/ do |collection, attr|
  collection = collection.pluralize
  @products.send(collection).should_not be_nil
  @products.send(collection).should_not be_empty

  @products.send(collection).each do |i|
    i.send(attr).should_not be_nil
    if i.send(attr).respond_to?(:empty?)
      i.send(attr).should_not be_empty
    end
  end
end

