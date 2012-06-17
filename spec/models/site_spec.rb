require 'spec_helper'

describe Site do
  it "can be created with a destination" do
    Site.new({ destination: "www.somerandomurl.com" }).should be_valid
  end

  it "cannot be created without a destination" do
    Site.new.should_not be_valid
  end

  context "associations" do
    it { should belong_to(:user) }
  end

  context "string generator" do
    it "should create a random string" do
      @str = Site.generate_string
      @str.should be_a_kind_of(String)
    end

    it "set_short_path should assign short_path to an instance" do
      @site = Site.new
      @site.set_short_path
      @site.short_path.should_not be_nil
    end

    it "should not modify an instance that already has a short_path" do
      @site = Site.new
      @site.short_path = "abcdef"
      @site.set_short_path
      @site.short_path.should == "abcdef"
    end
  end

  context "check_format method" do
    it "should add http:// if its missing" do
      @site = Site.new(:destination => "www.grass.org")
      @site.check_destination_format
      @site.save
      @site.destination.should == "http://www.grass.org"
    end

    it "should add http://www. if its missing" do
      @site = Site.new(:destination => "grass.org")
      @site.check_destination_format
      @site.save
      @site.destination.should == "http://www.grass.org"
    end

    it "should not modify destinations that have correct format" do
      @site = Site.new(:destination => "http://www.grass.org")
      @site.check_destination_format
      @site.save
      @site.destination.should == "http://www.grass.org"
    end
  end
end
