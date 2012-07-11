require 'spec_helper'

module Dcm4chee
  describe FileSystem do
    describe '#path' do
      before(:all) do
        @config = Dcm4chee.config.clone
      end

      after(:all) do
        Dcm4chee.instance_variable_set(:'@config', @config)
      end

      context 'when the dir of dcm4chee is not set' do
        let(:file_system) { create(:file_system, path: 'archive') }

        before(:all) do
          Dcm4chee.configure { server_home nil }
        end

        it 'raises missing the dir of dcm4chee error' do
          expect{ file_system.path }.to raise_error('Home of dcm4chee must be set')
        end
      end

      context 'when the dir of dcm4chee is set' do
        before(:all) do
          Dcm4chee.configure { server_home '/tmp' }
        end

        context 'and given a relative path' do
          let(:file_system) { create :file_system, path: 'archive' }

          it 'directs to a path under the dir path of dcm4chee' do
            expect(file_system.path).to eql('/tmp/server/default/archive')
          end
        end

        context 'and given a absolute path' do
          let(:file_system) { create :file_system, path: '/tmp' }

          it 'uses the path' do
            expect(file_system.path).to eql('/tmp')
          end
        end
      end
    end
  end
end
