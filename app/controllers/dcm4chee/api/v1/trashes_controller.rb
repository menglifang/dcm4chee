# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class TrashesController < BaseController
        # 清空回收站中的所有信息
        #
        # @example
        #   # 请求
        #   DELETE /api/trash HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        def destroy
          Dcm4chee.content_edit_service.empty_trash

          head :ok
        end
      end
    end
  end
end
