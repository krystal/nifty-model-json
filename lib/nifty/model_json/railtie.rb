module Nifty
  module ModelJSON
    class Railtie < Rails::Railtie
      
      initializer 'nifty.model_json.initialize' do
        ActiveSupport.on_load(:active_record) do
          require 'nifty/model_json/active_record_extension'
          ActiveRecord::Base.send :include, Nifty::ModelJSON::ActiveRecordExtension
        end
      end
      
    end
  end
end
