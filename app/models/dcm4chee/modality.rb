module Dcm4chee
  class Modality
    include ::Virtus

    attribute :name, String

    def self.all
      modalities = []

      [Series.modalities, TrashedSeries.modalities].each do |names|
        names.each do |n|
          modalities << Modality.new(name: n)
        end
      end

      modalities
    end
  end
end
