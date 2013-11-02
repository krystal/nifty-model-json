module Nifty
  module ModelJSON
    module ActiveRecordExtension
      
      def self.included(base)
        base.extend ClassMethods
      end
      
      def to_nifty_json_hash(options = {})
        self.class.nifty_json_methods.select { |m| m[:options][:if].nil? || m[:options][:if].call(self, options) }.inject({}) do |full_hash, attr|
          
          if attr[:options][:group]
            hash = full_hash[attr[:options][:group]] ||= {}
          else
            hash = full_hash
          end
          
          value = self.send(attr[:name])
          case value
          when ActiveRecord::Base
            value = value.to_nifty_json_hash
          when ActiveRecord::Associations::CollectionProxy
            value = value.map(&:to_nifty_json_hash)
          end
          
          hash[attr[:options][:as] || attr[:name]] = value
          full_hash
        end
      end

      def to_nifty_json(options = {})
        to_nifty_json_hash(options).to_json
      end
            
      module ClassMethods
        
        def nifty_json_methods
          @nifty_json_methods ||= [{:name => :id, :options => {}}]
        end

        def json(*attrs)
          options = attrs.select { |a| a.is_a?(Hash) }.first || {}
          attrs.select { |a| a.is_a?(Symbol) }.each do |attr|
            self.nifty_json_methods << {:name => attr, :options => options}
          end
        end
        
      end
      
    end
  end
end
