# -*- encoding: utf-8 -*-
module Dcm4chee
  module Service
    class MoveScuService < MBean

      MBEAN_NAME = 'dcm4chee.archive:service=MoveScu'

      # Move data to AE
      #
      # @param [String]  retrieve_aet
      # @param [String]  dest_aet
      # @param [Integer] priority DICOM priority(0: Medium, 1: High, 2: Low)
      # @param [String]  pid
      # @param [Array]   study_iuids
      # @param [Array]   series_iuids
      # @param [Array]   sop_iuids
      # @param [Integer] scheduled_time(milliseconds from 1970-01-01 00:00:00)
      #
      # @return [Hash] Result
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
