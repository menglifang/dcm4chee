module Dcm4chee
  module Trashable
    def move_to_trash
      Dcm4chee.content_edit_service.
        send("move_#{self.class.name.downcase}_to_trash".to_sym, id)
    end

    def restore_from_trash
      Dcm4chee.content_edit_service.
        send("undelete_#{self.class.name.downcase}".to_sym, id)
    end

    def remove_from_trash
      Dcm4chee.content_edit_service.
        send("delete_#{self.class.name.downcase}".to_sym, id)
    end
  end
end
