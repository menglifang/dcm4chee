module Dcm4chee
  class Modality
    include ::Virtus

    attribute :name, String

    def self.all
      Series.modalities.inject([]) do |c, n|
        c << Modality.new(name: n)
      end
    end
  end
end
