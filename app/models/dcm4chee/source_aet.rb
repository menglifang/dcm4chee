module Dcm4chee
  class SourceAet
    include ::Virtus

    attribute :name, String

    def self.all
      source_aets = []

      [Series.source_aets, TrashedSeries.source_aets].each do |names|
        names.each do |n|
          source_aets << SourceAet.new(name: n)
        end
      end

      source_aets
    end
  end
end
