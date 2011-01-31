class ResellersController < ApplicationController
  inherit_resources
  defaults :resource_class => Reseller, :collection_name => 'resellers', :instance_name => 'reseller'
end
