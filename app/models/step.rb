# sexp Pattern
#
#   [:step_invocation, line, keyword, text, (table/heredoc)]
#
class Step
  
  
  
  def initialize(scenario, sexp)
    @line = sexp[1]
    @term = sexp[2]
    @text = sexp[3]
    child = sexp[4]
    if child
      table?(child)   && (@table   = Table.new(child))
      heredoc?(child) && (@heredoc = child[1])
    end
  end
  
  
  
  attr_reader   :line,
                :term,
                :text
  attr_accessor :table
  attr_accessor :heredoc
  
  
  
  def render
    output = "    #{term}#{text}\n"
    output << table.render if table
    if heredoc
      output << "      \"\"\"\n"
      heredoc.split($/).each do |line|
        output << "      #{line}\n"
      end
      output << "      \"\"\"\n"
    end
    output
  end
  
  
  
private
  
  
  
  def table?(sexp)
    sexp.first == :table
  end
  
  def heredoc?(sexp)
    sexp.first == :doc_string
  end
  
  
  
end