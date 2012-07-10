require 'virtus'
require 'dicom'

module Dcm4chee
  module DicomObject
    extend ActiveSupport::Concern

    class Element
      include ::Virtus

      attribute :name, String
      attribute :value, String
      attribute :tag, String
      attribute :value_representation, String
      attribute :length, Integer
    end

    def dcm
      tsuid = defined?(dicom_file) ? dicom_file.transfer_syntax_uid : ::DICOM::EXPLICIT_LITTLE_ENDIAN

      return nil unless dicom_attributes

      # TODO Cache it
      ::DICOM::DObject.parse(dicom_attributes.gsub(/\\x/, '').to_byte_string,
                             syntax: tsuid)
    end

    def dcm_elements
      return [] unless dcm

      @elements ||= begin
                      @elements = []
                      dcm.elements.each do |e|
                        @elements << Element.new(name: e.name,
                                                 value: e.value.to_s,
                                                 tag: e.tag,
                                                 value_representation: e.vr,
                                                 length: e.length)
                      end

                      @elements
                    end
    end

    def as_json(opts = {})
      opts[:exclude] ||= []
      opts[:exclude] << :dicom_attributes

      opts[:methods] ||= []
      opts[:methods] << :dcm_elements

      super(opts)
    end

    module ClassMethods
      def dicom_field(name)
        property :dicom_attributes,
                 ::DataMapper::Property::Binary, field: name,
                 accessor: :private
      end
    end
  end
end
