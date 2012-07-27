module Dcm4chee
  module Api
    module V1
      class ModalitiesController < BaseController
        respond_to :json

        # 列出所有成像设备
        #
        # @example
        #   # 请求
        #   GET /api/modalities HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
        #     "modalities": [{
        #       "name": ...
        #     }, ...]
        #   }
        def index
          modalities = Modality.all

          render json: { modalities: modalities }
        end
      end
    end
  end
end
