module Dcm4chee
  class DicomObjectManager
    def move(dest_aet, study_iuids, series_iuids, instance_iuids)
      move_studies(dest_aet, study_iuids)

      series_iuids.each { |k, v| move_series(dest_aet, k, v) }

      instance_iuids.each do |key, val|
        val.each { |k, v| move_instances(dest_aet, key, k, v) }
      end
    end

    private

    def move_studies(dest_aet, study_iuids)
      Dcm4chee.move_scu_service.schedule_move(
        nil,
        dest_aet,
        0,
        nil,
        study_iuids
      )
    end

    def move_series(dest_aet, study_iuid, series_iuids)
      Dcm4chee.move_scu_service.schedule_move(
        nil,
        dest_aet,
        0,
        nil,
        [study_iuid],
        series_iuids
      )
    end

    def move_instances(dest_aet, study_iuid, series_iuid, instance_iuids)
      Dcm4chee.move_scu_service.schedule_move(
        nil,
        dest_aet,
        0,
        nil,
        [study_iuid],
        [series_iuid],
        instance_iuids
      )
    end
  end
end
