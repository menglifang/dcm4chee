# -*- encoding: utf-8 -*-
module Dcm4chee
  class ApplicationEntity
    include DataMapper::Resource

    storage_names[Dcm4chee.config.repository_name] = 'ae'

    # @return [Integer] primary key
    property :id, Serial, field: 'pk'

    # @return [String] name
    property :title, String, field: 'aet'

    # @return [String] hostname or ip address
    property :host, String, field: 'hostname'

    # @return [Integer] port
    property :port, Integer, field: 'port'

    # @return [String] cipher_suites, available values:SSL_RSA_WITH_NULL_SHA, TLS_RSA_WITH_AES_128_CBC_SHA, SSL_RSA_WITH_3DES_EDE_CBC_SHA
    #   Multi-suites should be specified in comma-separated format.
    property :cipher_suites, String, field: 'cipher_suites'

    # @return [String] issuer of the patient id
    property :patient_id_issuer, String, field: 'pat_id_issuer'

    # @return [String] issuer of the accession number
    property :accession_number_issuer, String, field: 'acc_no_issuer'

    # @return [String] username
    property :username, String, field: 'user_id'

    # @return [String] password
    property :password, String, field: 'passwd'

    # @return [String] group of the file system
    property :fs_group, String, field: 'fs_group_id', default: 'ONLINE_STORAGE'

    # @return [String] group of the application entity
    property :group, String, field: 'ae_group'

    # @return [String] description
    property :description, String, field: 'ae_desc'

    # @return [String] url of WADO
    property :wado_url, String, field: 'wado_url'

    # @return [String] station name
    property :station_name, String, field: 'station_name'

    # @return [String] institution
    property :institution, String, field: 'institution'
    
    # @return [String] department
    property :department, String, field: 'department'

    # @return [String] installed or not
    property :installed, String, field: 'installed'

    # Update an application entity through AEService of dcm4chee.
    #
    # @param [Hash] attrs Attributes of the application entity
    def update_by_service(attrs = {})
      params = [
        id,
        attrs[:title] || title,
        attrs[:host] || host,
        attrs[:port] || port,
        attrs[:cipher_suites] || cipher_suites,
        attrs[:patient_id_issuer] || patient_id_issuer,
        attrs[:accession_number_issuer] || accession_number_issuer,
        attrs[:username] || username,
        attrs[:password] || password,
        attrs[:fs_group] || fs_group,
        attrs[:group] || group,
        attrs[:description] || description,
        attrs[:wado_url] || wado_url,
        attrs[:station_name] || station_name,
        attrs[:institution] || institution,
        attrs[:department] || department,
        attrs[:installed] || installed,
        true
      ]
      Dcm4chee.application_entity_service.update_ae(params)
      reload

      self
    end

    # Delete an application entity through AEService of dcm4chee
    def destroy_by_service
      Dcm4chee.application_entity_service.remove_ae(title)
    end

    class << self
      # Create an application entity through AEService of dcm4chee.
      #
      # @param [Hash] attrs Attributes of the new application entity
      def create_by_service(attrs = {})
        params = [
          attrs[:title],
          attrs[:host],
          attrs[:port],
          attrs[:cipher_suites],
          attrs[:patient_id_issuer],
          attrs[:accession_number_issuer],
          attrs[:username],
          attrs[:password],
          attrs[:fs_group],
          attrs[:group],
          attrs[:description],
          attrs[:wado_url],
          attrs[:station_name],
          attrs[:institution],
          attrs[:department],
          !!(attrs[:installed]),
          true
        ]
        Dcm4chee.application_entity_service.add_ae(params)

        first(title: attrs[:title])
      end

      def repository(name = nil, &block)
        super(Dcm4chee.config.repository_name, &block)
      end
    end
  end
end
