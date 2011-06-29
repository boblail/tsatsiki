class Step
  
  
  
  def initialize(scenario, sexp)
    @line = sexp[1]
    @term = sexp[2]
    @text = sexp[3]
    @table = sexp[4] && Table.new(sexp[4])
  end
  
  
  
  attr_reader   :line,
                :term,
                :text
  attr_accessor :table
  
  
  
  def render
    output = "    #{term}#{text}\n"
    output << table.render if table
    output
  end
  
  
  
end