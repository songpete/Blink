require 'spec_helper'

describe User do
  context "associations" do
    it { should have_many(:sites) }
  end

  context "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  context "fabricators" do
    it "should create a valid user" do
      Fabricate(:user).should be_valid
    end
  end

  context "on sign up" do
    it "should save with a valid email" do
      @user = User.new(:email => 'myaddy@email.com', :password => 'secret')
      @user.should be_valid
    end

    it "should not save without a valid email format" do
      @user = User.new(:email => 'myaddy@email', :password => 'secret')
      @user.should_not be_valid
    end

    it "should not save if email is a duplicate" do
      @user1 = User.create(:email => 'firstevaruser@hotmail.com', :password => 'secret')
      @user2 = User.new(:email => 'firstevaruser@hotmail.com', :password => 'scrambledeggs')
      @user2.should_not be_valid
    end

    it "should not save if password is too short" do
      @user = User.new(:email => 'hotdog@hotmail.com', :password => 'hi')
      @user.should_not be_valid
    end

    it "should not save if password & confirmation don't match" do
      @user = User.new(:email => 'myaddy@email.com', :password => 'secret', :password_confirmation => 'super')
      @user.should_not be_valid
    end
  end
end
