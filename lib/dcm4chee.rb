require 'data_mapper'
require 'confstruct'
require 'jolokia'
require 'sys/filesystem'
require 'dm-searcher'

require 'dcm4chee/engine'
require 'dcm4chee/api_constraints'
require 'dcm4chee/content_edit_service'
require 'dcm4chee/file_system_management'

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

    def content_edit_service
      @content_edit_service ||= Dcm4chee::ContentEditService.new(jolokia)
    end

    def file_system_management
      @file_system_management ||= Dcm4chee::FileSystemManagement.new(jolokia)
    end
  end
end

require 'dcm4chee/dicom_object'
require 'dcm4chee/trashable'
