module Dcm4chee
  module Service
    class ContentEditService

      MBEAN_NAME = 'dcm4chee.archive:service=ContentEditService'

      attr_accessor :jolokia

      def initialize(jolokia)
        @jolokia = jolokia
      end

      def empty_trash
        jolokia.execute(MBEAN_NAME, 'emptyTrash')
      end

      class << self
        def define_component(name)
          define_method("move_#{name}_to_trash".to_sym) do |id|
            jolokia.execute(MBEAN_NAME,
                            "move#{name}ToTrash(long)", id)
          end

          define_method("undelete_#{name}".to_sym) do |id|
            jolokia.execute(MBEAN_NAME,
                            "undelete#{name}(long)", id)
          end

          define_method("delete_#{name}".to_sym) do |id|
            jolokia.execute(MBEAN_NAME,
                            "delete#{name}(long)", id)
          end
        end
      end

      define_component :patient
      define_component :study
      define_component :series
      define_component :instance
    end
  end
end
