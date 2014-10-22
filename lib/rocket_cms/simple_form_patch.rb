# https://github.com/rs-pro/russian/blob/master/lib/russian/active_model_ext/custom_error_message.rb
require 'simple_form/components/errors'
module SimpleForm
  module Components
    module Errors
      protected
      def errors_on_attribute
        object.errors[attribute_name].map {|m| m.sub(/^\^/, '')}
      end
    end
  end
end
