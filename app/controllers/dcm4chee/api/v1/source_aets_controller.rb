module Dcm4chee
  module Api
    module V1
      class SourceAetsController < BaseController
        respond_to :json

        # 列出所有源AET
        #
        # @example
        #   # 请求
        #   GET /api/source_aets HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
        #     "source_aets": [{
        #       "name": ...
        #     }, ...]
        #   }
        def index
          source_aets = SourceAet.all

          render json: { source_aets: source_aets }
        end
      end
    end
  end
end
