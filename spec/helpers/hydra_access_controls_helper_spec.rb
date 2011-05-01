require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HydraAccessControlsHelper do
  
  describe "admin_policy_object_editor?" do 
    it "should return true if current_user.is_being_superuser? is true" do
        mock_user = mock("User", :login => "BigWig")
        mock_user.stubs(:is_being_superuser?).returns true
        helper.stubs(:current_user).returns mock_user
        helper.admin_policy_object_editor?.should be_true
    end
    it "should return false if the session[:user] is not logged in" do
      helper.stubs(:current_user).returns(nil)
      helper.admin_policy_object_editor?.should be_false
    end
    it "should return false if the session[:user] does not have an editor role" do
      mock_user = mock("User", :login=>"nobody_special")
      RoleMapper.stubs(:roles).returns(["public"])
      mock_user.stubs(:is_being_superuser?).returns(false)
      helper.stubs(:current_user).returns(mock_user)
      helper.admin_policy_object_editor?.should be_false
    end
    it "should return true if the session[:user] has admin_policy_object_editor role" do
       mock_user = mock("SetEditor", :login=>"set_editor")
       mock_user.stubs(:is_being_superuser?).returns(false)
       RoleMapper.stubs(:roles).returns(["admin_policy_object_editor"])
       helper.stubs(:current_user).returns(mock_user)
       helper.admin_policy_object_editor?.should be_true
    end
  
  end
  
  describe "admin_policy_object_editor?" do 
    it "should return true if current_user.is_being_superuser? is true" do
        mock_user = mock("User", :login => "BigWig")
        mock_user.stubs(:is_being_superuser?).returns true
        helper.stubs(:current_user).returns mock_user
        helper.admin_policy_object_editor?.should be_true
    end
    it "should return false if the session[:user] is not logged in" do
      helper.stubs(:current_user).returns(nil)
      helper.admin_policy_object_editor?.should be_false
    end
    it "should return false if the session[:user] does not have an editor role" do
      mock_user = mock("User", :login=>"nobody_special")
      RoleMapper.stubs(:roles).returns(["public"])
      mock_user.stubs(:is_being_superuser?).returns(false)
      helper.stubs(:current_user).returns(mock_user)
      helper.admin_policy_object_editor?.should be_false
    end
    it "should return true if the session[:user] has admin_policy_object_editor role" do
       mock_user = mock("SetEditor", :login=>"set_editor")
       mock_user.stubs(:is_being_superuser?).returns(false)
       RoleMapper.stubs(:roles).returns(["admin_policy_object_editor"])
       helper.stubs(:current_user).returns(mock_user)
       helper.admin_policy_object_editor?.should be_true
    end
  
  end
  
end
