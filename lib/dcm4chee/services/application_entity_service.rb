# -*- encoding: utf-8 -*-
module Dcm4chee
  module Service
    class ApplicationEntityService
      MBEAN_NAME = 'Dcm4chee.archive:service=AE'

      attr_accessor :jolokia

      def initialize(jolokia)
        @jolokia = jolokia
      end

      class << self
        # 用于添加应用实体。
        #
        # @param [Array] attr_values 应用实体属性
        #   0.   [String]       名称（title）
        #   1.   [String]       主机名/IP地址（host）
        #   2.   [Integer]      端口（port）
        #   3.   [String]       密码组（cipher_suites），取值（SSL_RSA_WITH_NULL_SHA，TLS_RSA_WITH_AES_128_CBC_SHA， SSL_RSA_WITH_3DES_EDE_CBC_SHA）
        #   4.   [String]       病人编号创建者（patient_id_issuer）
        #   5.   [String]       登记号创建者（accession_number_issuer）
        #   6.   [String]       用户名（username）
        #   7.   [String]       密码（password）
        #   8.   [String]       文件存储系统组（fs_group）
        #   9.   [String]       应用实体组（group）
        #   10.  [String]       描述（description）
        #   11.  [String]       WADO地址（wado_url）
        #   12.  [String]       站名称（station_name）
        #   13.  [String]       机构名称（institution）
        #   14.  [String]       部门名称（department）
        #   15.  [Boolean]      是否已安装（installed），表明该应用实体是否已经安装并可以
        #   16.  [Boolean]      是否检测（check_host）
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
            'java.lang.String',
            'boolean',
            'boolean'
          ]

          jolokia.execute(MBEAN_NAME,
                          "addAE(#{signatures.join(',')})",
                          attr_values)

        end

        # 用于更新应用实体。
        #
        # @param [Array] attr_values 应用实体属性
        #   0.   [Integer]      ID，值为-1时，为添加，否则为更新。
        #   1.   [String]       名称（title）
        #   2.   [String]       主机名/IP地址（host）
        #   3.   [Integer]      端口（port）
        #   4.   [String]       密码组（cipher_suites），取值（SSL_RSA_WITH_NULL_SHA，TLS_RSA_WITH_AES_128_CBC_SHA， SSL_RSA_WITH_3DES_EDE_CBC_SHA）
        #   5.   [String]       病人编号创建者（patient_id_issuer）
        #   6.   [String]       登记号创建者（accession_number_issuer）
        #   7.   [String]       用户名（username）
        #   8.   [String]       密码（password）
        #   9.   [String]       文件存储系统组（fs_group）
        #   10.  [String]       应用实体组（group）
        #   11.  [String]       描述（description）
        #   12.  [String]       WADO地址（wado_url）
        #   13.  [String]       站名称（station_name）
        #   14.  [String]       机构名称（institution）
        #   15.  [String]       部门名称（department）
        #   16.  [Boolean]      是否已安装（installed），表明该应用实体是否已经安装并可以
        #   17.  [Boolean]      是否检测（check_host）
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
            'java.lang.String',
            'boolean',
            'boolean'
          ]

          jolokia.execute(MBEAN_NAME,
                          "updateAE(#{signatures.join(',')})",
                          attr_values)
        end
      end
    end
  end
end
