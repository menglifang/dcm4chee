Rails.application.routes.draw do

  mount Dcm4chee::Engine => "/dcm4chee"
end
