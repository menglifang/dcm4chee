# -*- encoding: utf-8 -*-
module Dcm4chee
  module Service
    class MoveScuService < MBean

      MBEAN_NAME = 'dcm4chee.archive:service=MoveScu'

      # 迁移数据到指定的应用实体
      #
      # @param [String]  retrieve_aet 调用的应用实体
      # @param [String]  dest_aet 目的应用实体
      # @param [Integer] priority DICOM优先级（0：中，1：高，2：低）
      # @param [String]  pid 病人编号
      # @param [Array]   study_iuids 研究实例UIDs
      # @param [Array]   series_iuids 研究序列实例UIDs
      # @param [Array]   sop_iuids 实例UIDs
      # @param [Integer] scheduled_time 计划时间（距1970-01-01 00:00:00的毫秒数）
      #
      # @return [Hash] 执行结果
      def schedule_move(retrieve_aet,
                        dest_aet,
                        priority,
                        pid,
                        study_iuids,
                        series_iuids = nil,
                        sop_iuids = nil,
                        scheduled_time = 0)
        signatures = [
          'java.lang.String',
          'java.lang.String',
          'int',
          'java.lang.String',
          '[Ljava.lang.String;',
          '[Ljava.lang.String;',
          '[Ljava.lang.String;',
          'long'
        ]

        jolokia.execute(MBEAN_NAME,
                        "scheduleMove(#{signatures.join(',')})",
                        [
                          retrieve_aet,
                          dest_aet,
                          priority || 0,
                          pid,
                          study_iuids,
                          series_iuids,
                          sop_iuids,
                          scheduled_time
                        ])
      end
    end
  end
end
