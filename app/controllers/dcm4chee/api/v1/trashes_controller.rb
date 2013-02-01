# -*- encoding: utf-8 -*-
module Dcm4chee
  module Api
    module V1
      class TrashesController < BaseController
        # Clean up the trash.
        #
        # @example
        #   # Request
        #   DELETE /api/trash HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
        #   HTTP/1.1 200 OK
        def destroy
          Dcm4chee.content_edit_service.empty_trash

          head :ok
        end
      end
    end
  end
end
