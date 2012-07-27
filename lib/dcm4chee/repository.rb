module Dcm4chee
  module Repository
    extend ActiveSupport::Concern

    included do
      include DataMapper::Resource
    end

    module ClassMethods
      def table_name(name)
        storage_names[Dcm4chee.config.repository_name] = name
      end

      def repository(name = nil, &block)
        super(Dcm4chee.config.repository_name, &block)
      end
    end
  end
end
