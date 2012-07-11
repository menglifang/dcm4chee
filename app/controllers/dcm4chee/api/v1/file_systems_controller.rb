# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class FileSystemsController < BaseController
        respond_to :json

        # 列出所有文件存储系统，及其空间使用状态。
        #
        # @example
        #   # 请求
        #   GET /api/file_systems HTTP/1.1
        #   Accept: application/vnd.menglifang.s2pms.v1
        #
        #   # 响应
        #   HTTP/1.1 200 OK
        #   {
        #     "file_systems": [{
        #       "id": ...,
        #       "path": ...,
        #       "total_space": ...,
        #       "free_space": ...,
        #       "used_space": ...,
        #       "min_free_space": ...,
        #       "expected_space_per_day": ...,
        #       "remaining_days": ...
        #     }, ...]
        #   }
        def index
          file_systems = FileSystem.online

          respond_with file_systems: file_systems
        end
      end
    end
  end
end
