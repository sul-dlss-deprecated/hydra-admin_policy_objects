require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "active_fedora"


describe AdminPolicyObject do
  
  before(:each) do
    Dor::SuriService.expects(:mint_id).returns("test:AdminPolicyObjectTest")
    @sample =  AdminPolicyObject.new()
  end

  describe "It should inherit and behave correctly" do
     it "It should have a correct druid sent from Dor::SuriService" do
        @sample.pid.should == "test:AdminPolicyObjectTest"
     end
    
    it "should have a class superclass of Dor::Base" do
      @sample.class.superclass.should == Dor::Base
    end
    
    it "should make sure its a ActiveFedora::Base" do
      @sample.should be_a_kind_of(ActiveFedora::Base)
      @sample.class.ancestors.should include ActiveFedora::Base
    end
    
    it "should make sure its be an instance of AdminPolicyObject" do
      @sample.should be_a_kind_of(AdminPolicyObject)
    end
  end


  describe "create and save" do
    it "should save and index successfully" do
      @sample.save.should be_true
    end
    it "should delete successfully" do
      @sample.delete.should be_true
      lambda {  ActiveFedora::Base.load_instance("test:AdminPolicyObjectTest") }.should raise_error(ActiveFedora::ObjectNotFoundError)  
    end
  end

  describe "should have members associated to the admin set" do
     after(:all) do
        ActiveFedora::Base.load_instance("test:testObject").delete
        ActiveFedora::Base.load_instance("test:AdminPolicyObjectTest").delete
      end
      
    it "should allow for relationships to be extablished" do
      @testObject = DorObject.new(:pid => "test:testObject")
      @sample.add_relationship(:is_member_of, @testObject).should be_true
      @testObject.save.should be_true
      @sample.save.should be_true
    end
    
    it "should have the correct member associated after it's been saved" do 
       pending("use the #members method for the AdminPolicyObject object") do
         @sample_relationship = AdminPolicyObject.load_instance("test:AdminPolicyObjectTest")
         @sample_relationship.members(:response_format=>:id_array).first.should ==  "test:testObject"
       end 
    end
  end 

  describe "check the structure of the objects" do
    it "should have the default datastreams in fedora" do 
      identityMetadata = @sample.datastreams["identityMetadata"]
      dc = @sample.datastreams["DC"]
      administrativeMetadata = @sample.datastreams["administrativeMetadata"]
      defaultObjectRights = @sample.datastreams["defaultObjectRights"]
    
      identityMetadata.should be_a_kind_of(Stanford::IdentityMetadataDs)
      identityMetadata.should be_a_kind_of(ActiveFedora::NokogiriDatastream) 
    
      dc.should be_a_kind_of(Stanford::SimpleDublinCoreDs)
      dc.should be_a_kind_of(ActiveFedora::NokogiriDatastream)
    
      #these two will eventually get their own models. 
      administrativeMetadata.should be_a_kind_of(ActiveFedora::NokogiriDatastream)
      defaultObjectRights.should be_a_kind_of(ActiveFedora::NokogiriDatastream)
    end
    
    # The object model for this has changes so much this is a sanity check. 
    it "should not have certain datastreams" do
      @sample.datastreams.keys.should_not include "descMetadata"
    end
    
  end

end
