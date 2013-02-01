module Dcm4chee
  module Api
    module V1
      class ModalitiesController < BaseController
        respond_to :json

        # List modalities
        #
        # @example
        #   # Request
        #   GET /api/modalities HTTP/1.1
        #   Accept: application/vnd.menglifang.org; version=1
        #
        #   # Response
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
