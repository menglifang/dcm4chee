module Dcm4chee
  module Service
    class ContentEditService < MBean

      MBEAN_NAME = 'dcm4chee.archive:service=ContentEditService'

      def empty_trash
        jolokia.execute(MBEAN_NAME, 'emptyTrash')
      end

      class << self
        def define_component(name)
          name = name.to_s

          if name.started_with?('trashed')
            define_method("undelete_#{name}".to_sym) do |id|
              jolokia.execute(MBEAN_NAME,
                              "undelete#{name.camelize}(long)", id)
            end

            define_method("delete_#{name}".to_sym) do |id|
              jolokia.execute(MBEAN_NAME,
                              "delete#{name.camelize}(long)", id)
            end
          else
            define_method("move_#{name}_to_trash".to_sym) do |id|
              jolokia.execute(MBEAN_NAME,
                              "move#{name.camelize}ToTrash(long)", id)
            end
          end
        end
      end

      define_component :patient
      define_component :study
      define_component :series
      define_component :instance

      define_component :trashed_patient
      define_component :trashed_study
      define_component :trashed_series
    end
  end
end
