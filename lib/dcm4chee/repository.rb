module Dcm4chee
  module Repository
    extend ActiveSupport::Concern

    included do
      include DataMapper::Resource

      class_eval do
        def self.repository(name = nil, &block)
          super(Dcm4chee.config.repository_name, &block)
        end
      end
    end

    module ClassMethods
      def table_name(name)
        storage_names[Dcm4chee.config.repository_name] = name
      end
    end
  end
end
