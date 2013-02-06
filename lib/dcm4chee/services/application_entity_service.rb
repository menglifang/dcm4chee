# -*- encoding: utf-8 -*-
module Dcm4chee
  module Service
    class ApplicationEntityService < MBean

      MBEAN_NAME = 'dcm4chee.archive:service=AE'

      # Create application entities.
      #
      # @param [Array] attr_values Attributes of an application entity
      #   0.   [String]       title
      #   1.   [String]       host
      #   2.   [Integer]      port
      #   3.   [String]       cipher_suites, SSL_RSA_WITH_NULL_SHA, TLS_RSA_WITH_AES_128_CBC_SHA, SSL_RSA_WITH_3DES_EDE_CBC_SHA
      #   4.   [String]       patient_id_issuer
      #   5.   [String]       accession_number_issuer
      #   6.   [String]       username
      #   7.   [String]       password
      #   8.   [String]       fs_group
      #   9.   [String]       ae_group
      #   10.  [String]       description
      #   11.  [String]       wado_url
      #   12.  [String]       station_name
      #   13.  [String]       institution
      #   14.  [String]       department
      #   15.  [Boolean]      installed
      #   16.  [Boolean]      check_host
      def add_ae(attr_values)
        signatures = [
          'java.lang.String',
          'java.lang.String',
          'int',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'boolean',
          'boolean'
        ]

        jolokia.execute(MBEAN_NAME,
                        "addAE(#{signatures.join(',')})",
                        attr_values)

      end

      # Update application entities.
      #
      # @param [Array] attr_values Attributes of an application entity.
      #   0.   [Integer]      ID，Add a new one if id is -1. if not, update an existed one
      #   1.   [String]       title
      #   2.   [String]       host
      #   3.   [Integer]      port
      #   4.   [String]       cipher_suites, SSL_RSA_WITH_NULL_SHA,TLS_RSA_WITH_AES_128_CBC_SHA, SSL_RSA_WITH_3DES_EDE_CBC_SHA
      #   5.   [String]       patient_id_issuer
      #   6.   [String]       accession_number_issuer
      #   7.   [String]       username
      #   8.   [String]       password
      #   9.   [String]       fs_group
      #   10.  [String]       ae_group
      #   11.  [String]       description
      #   12.  [String]       wado_url
      #   13.  [String]       station_name
      #   14.  [String]       institution
      #   15.  [String]       department
      #   16.  [Boolean]      installed
      #   17.  [Boolean]      check_host
      def update_ae(attr_values)
        signatures = [
          'long',
          'java.lang.String',
          'java.lang.String',
          'int',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'java.lang.String',
          'boolean',
          'boolean'
        ]

        jolokia.execute(MBEAN_NAME,
                        "updateAE(#{signatures.join(',')})",
                        attr_values)
      end

      # Delete an application entity.
      #
      # @param [String] title the title of the deleting AE.
      def remove_ae(title)
        jolokia.execute(MBEAN_NAME,
                        "removeAE(java.lang.String)",
                        title)
      end
    end
  end
end
