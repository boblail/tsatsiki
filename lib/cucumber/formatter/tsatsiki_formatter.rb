require 'cucumber/formatter/gherkin_formatter_adapter'
require 'gherkin/formatter/argument'
require 'gherkin/formatter/json_formatter'

module Cucumber
  module Formatter
    class TsatsikiFormatter < GherkinFormatterAdapter
      
      def initialize(step_mother, websocket, options)
        @websocket = websocket
        @options = options
        super(Gherkin::Formatter::JSONFormatter.new(nil), false)
      end
      
      def after_feature(feature)
        super
        @websocket.send_message('data', {:project_id => @options[:project_id], :data => @gf.gherkin_object})
      end
      
    end
  end
end
