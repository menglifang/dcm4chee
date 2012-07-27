module Dcm4chee
  class SourceAet
    include ::Virtus

    attribute :name, String

    def self.all
      Series.source_aets.inject([]) do |c, n|
        c << SourceAet.new(name: n)
      end
    end
  end
end
