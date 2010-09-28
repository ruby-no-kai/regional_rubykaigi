require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do

  describe "#fetch_event" do
    specify do
      get :name => "no_such_kaigi"
      response.status.should == "404 Not Found"
    end
  end
end
