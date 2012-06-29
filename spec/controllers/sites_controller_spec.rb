require 'spec_helper'

describe SitesController do
  context "with fabricators" do
    describe "GET index" do
      before(:each) do
        @site = Fabricate(:site)
      end

      it "assigns all sites to @sites" do
        get :index
        assigns(:sites).count.should == 1
        assigns(:sites).first.id.should == @site.id
      end
    end

    describe "Get new" do
      it "assigns @site" do
        get :new
        assigns(:site).class.should == Site
      end
    end

    describe "GET edit" do
      before(:each) do
        @site = Fabricate(:site)
      end

      it "retrieves requested site for editing" do
        get :edit, :id => @site.id
        assigns(:site).id.should == @site.id
      end
    end

    describe "POST create" do
      before(:each) do
        @pre_count = Site.count
      end
      it "creates a new site" do
        post :create, :site => { 'destination' => 'www.reddit.com' }
        Site.count.should == (@pre_count + 1)
        Site.last.destination.should == 'http://www.reddit.com'
      end
      it "should assign a created site to current_user if one is signed in" do
        @usr = Fabricate(:user)
        sign_in @usr
        post :create, :site => { 'destination' => 'www.somerandomsite.com' }
        @usr.sites.count.should == 1
        @usr.sites.last.destination.should == "http://www.somerandomsite.com"
      end
      it "should not create a new record if destination already exists" do
        @site1 = Site.create!(:destination => 'www.wikipedia.com')
        @first_count = Site.count
        post :create, :site => { 'destination' => 'www.wikipedia.com' }
        Site.count.should == @first_count
      end
    end

    describe "PUT update" do
      before(:each) do
        @site = Fabricate(:site)
      end
      it "updates site" do
        put :update, :id => @site.id.to_s, :site => { 'destination' => 'www.newsite.com' }
        @site.reload.destination.should == 'http://www.newsite.com'
      end
    end

    describe "DELETE destroy" do
      before(:each) do
        @user = Fabricate(:user)
        sign_in @user
        @site = Fabricate(:site)
      end
      it "destroys a site" do
        delete :destroy, :id => @site.id
        Site.count.should == 0
      end
    end
  end
end
