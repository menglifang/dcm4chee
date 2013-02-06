module Dcm4chee
  module Api
    module V1
      class SourceAetsController < BaseController
        respond_to :json

        # List AET
        #
        # @example
        #   # Request
        #   GET /api/source_aets HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
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
