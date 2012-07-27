require 'spec_helper'

module Dcm4chee
  describe Series do
    describe '.modalities' do
      before do
        create(:series, modality: 'CT')
        create(:series, modality: 'DR')
        create(:series, modality: 'DR')
        create(:series, modality: 'CR')
        create(:series, modality: 'CR')
        create(:series, modality: 'CR')
      end

      subject { Series.modalities }

      its(:count) { should == 3 }

      %w(CT DR CR).each do |name|
        specify { subject.should be_include name }
      end
    end
  end
end
