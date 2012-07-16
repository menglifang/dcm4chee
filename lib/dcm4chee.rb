require 'data_mapper'
require 'confstruct'
require 'jolokia'
require 'sys/filesystem'
require 'dm-searcher'

require 'dcm4chee/engine'
require 'dcm4chee/api_constraints'

require 'dcm4chee/services/mbean'
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

    def application_entity_service
      @application_entity_service ||= Dcm4chee::Service::ApplicationEntityService.new(jolokia)
    end

    def content_edit_service
      @content_edit_service ||= Dcm4chee::Service::ContentEditService.new(jolokia)
    end

    def file_system_management
      @file_system_management ||= Dcm4chee::Service::FileSystemManagement.new(jolokia)
    end

    def move_scu_service
      @move_scu_service ||= Dcm4chee::Service::MoveScuService.new(jolokia)
    end
  end
end

require 'dcm4chee/models/has_dicom_object'
require 'dcm4chee/models/trashable'
