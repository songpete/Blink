require 'spec_helper'

describe RedirectsController do
  describe "GET show" do
    before(:each) do
      @site = Fabricate(:site)
    end
    it "should add 1 to count on redirect" do
      get :show, { :path => 'abcdef' }
      @site.reload.count.should == 1
    end
  end

end
