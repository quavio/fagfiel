class FreebiesController < ApplicationController
  inherit_resources
  defaults :resource_class => Freebie, :collection_name => 'freebies', :instance_name => 'freebie'
end
