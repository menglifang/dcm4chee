module Dcm4chee
  module Api
    module V1
      class BaseController < ApplicationController
        before_filter :fill_param_q, only: :index

        private

        def fill_param_q
          params[:q] ||= {}
        end
      end
    end
  end
end
