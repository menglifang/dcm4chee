require 'data_mapper'
require 'confstruct'
require 'jolokia'
require 'sys/filesystem'
require 'dm-searcher'
require 'dm-pager'

require 'dcm4chee/engine'
require 'dcm4chee/api_constraints'
require 'dcm4chee/dicom_object_manager'

require 'dcm4chee/services/mbean'
require 'dcm4chee/services/application_entity_service'
require 'dcm4chee/services/content_edit_service'
require 'dcm4chee/services/file_system_management'
require 'dcm4chee/services/move_scu_service'

module Dcm4chee
  REPOSITORY_NAME = :dcm4chee

  class << self
    def jolokia
      @jolokia ||= ::Jolokia.new(url: config.jolokia_url)
    end

    def config
      @config ||= Confstruct::Configuration.new
    end

    def configure(&block)
      config.configure(&block)

      config.repository_name = REPOSITORY_NAME unless config.repository_name
      DataMapper.setup(:dcm4chee, config.repository_uri) if config.repository_uri
    end

    def respond_to?(method)
      Dcm4chee::Service.constants.include?(method.to_s.camelize.to_sym) || super(method)
    end

    def method_missing(name, *args, &block)
      service = instance_variable_get("@#{name}")
      return service if service

      begin
        service_class = "Dcm4chee::Service::#{name.to_s.camelize}".constantize
        service = service_class.new(jolokia)
        instance_variable_set("@#{name}", service)

        service
      rescue
        super(name, *args, &block)
      end
    end
  end
end

require 'dcm4chee/models/has_dicom_object'
