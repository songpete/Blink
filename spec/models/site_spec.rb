require 'spec_helper'

describe Site do
  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of :destination }
  end

  context "on creation" do
    it "should have a zero count" do
      @site = Fabricate(:site)
      @site.count.should == 0
    end
  end

  context "set_short_path on save" do
    subject do
      site = Site.new
      site.destination = "www.amazon.com"
      site
    end

    it "set_short_path method should assign short_path on save" do
      subject.save
      subject.short_path.should_not be_nil
    end

    it "should fill short_path with a random string" do
      subject.save
      subject.short_path.should be_a_kind_of(String)
    end

    it "should not modify an instance that already has a short_path" do
      subject.short_path = "abcdef"
      subject.save
      subject.short_path.should == "abcdef"
    end
  end

  context "check_format method" do
    it "should add http:// if its missing" do
      @site = Site.new(:destination => "www.grass.org")
      @site.save
      @site.destination.should == "http://www.grass.org"
    end

    it "should add http://www. if its missing" do
      @site = Site.new(:destination => "grass.org")
      @site.save
      @site.destination.should == "http://www.grass.org"
    end

    it "should not modify destinations that have correct format" do
      @site = Site.new(:destination => "http://www.grass.org")
      @site.save
      @site.destination.should == "http://www.grass.org"
    end
  end
end
