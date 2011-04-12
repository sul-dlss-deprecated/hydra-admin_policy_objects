
class AdminPolicyObject <  Dor::Base
#class AdminPolicyObject < ActiveFedora::Base
 
     include Hydra::ModelMethods
   has_relationship "members", :is_member_of, :inbound=>true

   # Both of these are Part of the dor_objects plugin. 
   has_metadata :name => "identityMetadata", :type => Stanford::IdentityMetadataDs
   has_metadata :name => "DC", :type => Stanford::SimpleDublinCoreDs
 
   #these objects still need to have their OM models built. Still waiting on Lynn to explain what they are. 
   has_metadata :name => "administrativeMetadata", :type => ActiveFedora::NokogiriDatastream     
   has_metadata :name => "defaultObjectRights", :type => ActiveFedora::NokogiriDatastream
  

  # Uses the Hydra Rights Metadata Schema for tracking access permissions & copyright
  has_metadata :name => "rightsMetadata", :type => Hydra::RightsMetadata 
  
  def to_solr(solr_doc=Solr::Document.new, opts={})
    super
    solr_doc << {:edit_access_group_t => "admin_policy_object_editor"}
    solr_doc
  end
end
