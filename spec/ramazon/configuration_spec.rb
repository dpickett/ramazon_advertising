require "spec_helper"

describe Ramazon::Configuration do
  it "should default to the us" do
    Ramazon::Configuration.locale.should eql(:us)
  end

  it "should raise an exception if a set a locale that doesn't exist" do
    lambda {Ramazon::Configuration.locale = :ffsf}.should raise_error
  end

  it "should derive a url of the locale" do
    Ramazon::Configuration.locale = :de
    Ramazon::Configuration.base_uri.should =~ /#{Ramazon::Configuration.locale.to_s}/
  end

  it "should use .com for a us address" do
    Ramazon::Configuration.locale = :us
    Ramazon::Configuration.base_uri.should =~ /\.com/
  end
  
  it "shold use .co.uk for the :uk locale" do
    Ramazon::Configuration.locale = :uk
    Ramazon::Configuration.base_uri.should =~ /\.co\.uk/
  end
end
