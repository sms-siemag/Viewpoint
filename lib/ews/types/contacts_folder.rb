module Viewpoint::EWS::Types
  class ContactsFolder
    include Viewpoint::EWS
    include Viewpoint::EWS::Types
    include Viewpoint::EWS::Types::GenericFolder

    # Create a new contact
    # @param attributes [Hash] Parameters of the contact. Some example attributes are listed below.
    # @option attributes :display_name [String]
    # @option attributes :given_name [String]
    # @option attributes :surname [String]
    # @option attributes :initials [String]
    # @option attributes :middle_name [String]
    # @option attributes :nickname[String]
    # @option attributes :suffix [String]
    def create_item(attributes)
      template = Viewpoint::EWS::Template::Contact.new attributes
      template.saved_item_folder_id = {id: self.id, change_key: self.change_key}
      rm = ews.create_item(template.to_ews_create).response_messages.first
      if rm && rm.success?
        Contact.new ews, rm.items.first[:contact][:elems].first
      else
        raise EwsCreateItemError, "Could not create item in folder. #{rm.code}: #{rm.message_text}" unless rm
      end      
    end

  end
end
