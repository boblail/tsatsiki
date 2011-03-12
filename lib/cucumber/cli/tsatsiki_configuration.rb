require 'cucumber/cli/configuration'

module Cucumber
  module Cli
    class TsatsikiConfiguration < ::Cucumber::Cli::Configuration
      
      def initialize(websocket, params)
        super()
        @websocket = websocket
        @options.parse!([])
        @options[:paths] = []
        @options[:project_id] = params['project_id']
      end
      
      def formatters(step_mother)
        [Cucumber::Formatter::TsatsikiFormatter.new(step_mother, @websocket, @options)]
      end
      
    end
  end
end
