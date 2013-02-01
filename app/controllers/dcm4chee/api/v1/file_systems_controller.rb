# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class FileSystemsController < BaseController
        respond_to :json

        # List the file systems including the status of them.
        #
        # @example
        #   # Request
        #   GET /api/file_systems HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
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
