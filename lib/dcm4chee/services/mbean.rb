module Dcm4chee
  module Service
    class MBean
      attr_accessor :jolokia

      def initialize(jolokia)
        @jolokia = jolokia
      end
    end
  end
end
