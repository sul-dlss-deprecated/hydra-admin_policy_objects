require File.expand_path( File.join( File.dirname(__FILE__), '..','..','spec_helper') )

require "hydra"

class FakeAssetsController
  include MediaShelf::ActiveFedoraHelper
end

def helper
  @fake_controller
end

describe MediaShelf::ActiveFedoraHelper do

  before(:all) do
    @fake_controller = FakeAssetsController.new
  end
  
  describe "retrieve_af_model" do
    it "should return a Model is the object is a Dor::Base" do
      result = helper.retrieve_af_model("generic_content")
      result.should == GenericContent
      result.superclass.should == Dor::Base
      result.included_modules.should include(ActiveFedora::Model) 
    end
  end
  
end