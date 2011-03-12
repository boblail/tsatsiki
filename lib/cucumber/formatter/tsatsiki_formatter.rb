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
        @websocket.send_message('result', {
          :project_id => @options[:project_id],
          :feature_file => feature.file,
          :scenarios => format_scenarios(@gf.gherkin_object)
        })
      end
      
      def format_scenarios(results)
        results['elements'].map do |element|
          {
            :line => element['line'],
            :status => get_status_of_steps(element['steps'])
          }
        end
      end
      
      def get_status_of_steps(steps)
        statuses = steps.map {|step| step['result']['status']}
        status = nil
        begin; status = statuses.shift; end while(status == "passed")
        status || "passed"
      end
      
    end
  end
end
