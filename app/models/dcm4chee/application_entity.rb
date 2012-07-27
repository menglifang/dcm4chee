# -*- encoding: utf-8 -*-
module Dcm4chee
  class ApplicationEntity
    include Repository

    table_name 'ae'

    # @return [Integer] 主键
    property :id, Serial, field: 'pk'

    # @return [String] 名称
    property :title, String, field: 'aet'

    # @return [String] 主机名称/IP地址
    property :host, String, field: 'hostname'

    # @return [Integer] 端口
    property :port, Integer, field: 'port'

    # @return [String] 密码组，取值：SSL_RSA_WITH_NULL_SHA，TLS_RSA_WITH_AES_128_CBC_SHA， SSL_RSA_WITH_3DES_EDE_CBC_SHA
    #   如果指定多个密码，密码之间用逗号分割。
    property :cipher_suites, String, field: 'cipher_suites'

    # @return [String] 病人ID创建者
    property :patient_id_issuer, String, field: 'pat_id_issuer'

    # @return [String] 登记号创建者
    property :accession_number_issuer, String, field: 'acc_no_issuer'

    # @return [String] 用户名
    property :username, String, field: 'user_id'

    # @return [String] 密码
    property :password, String, field: 'password'

    # @return [String] 文件存储系统组
    property :fs_group, String, field: 'fs_group_id', default: 'ONLINE_STORAGE'

    # @return [String] 分组
    property :group, String, field: 'ae_group'

    # @return [String] 描述
    property :description, String, field: 'ae_desc'

    # @return [String] WADO地址
    property :wado_url, String, field: 'wado_url'

    # @return [String] 所属站名称
    property :station_name, String, field: 'station_name'

    # @return [String] 所属机构名称
    property :institution, String, field: 'institution'
    
    # @return [String] 所属部门名称
    property :department, String, field: 'department'

    # @return [String] 是否已经安装
    property :installed, String, field: 'installed'

    # 通过dcm4chee发布的服务（AEService）更新应用实体
    #
    # @param [Hash] attrs 应用实体的属性
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
    end

    # 通过dcm4chee发布的服务（AEService）删除应用实体
    def destroy_by_service
      Dcm4chee.application_entity_service.remove_ae(title)
    end

    class << self
      # 通过dcm4chee发布的服务（AEService）创建应用实体
      #
      # @param [Hash] attrs 应用实体的属性
      def create_by_service(attrs = {})
        e = new(attrs)
        params = [
          e.title,
          e.host,
          e.port,
          e.cipher_suites,
          e.patient_id_issuer,
          e.accession_number_issuer,
          e.username,
          e.password,
          e.fs_group,
          e.group,
          e.description,
          e.wado_url,
          e.station_name,
          e.institution,
          e.department,
          e.installed,
          true
        ]

        Dcm4chee.application_entity_service.add_ae(params)
      end
    end
  end
end
