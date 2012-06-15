require 'spec_helper'

describe Site do
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
end
