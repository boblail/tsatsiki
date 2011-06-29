class Table
  
  
  
  # sexp Examples
  #
  #   [:table, [
  #     [:row, 7, [:cell, "questions"], [:cell, "answers"]],
  #     [:row, 8, [:cell, "Does Tsatsiki taste good with spaghetti?"], [:cell, "No"]],
  #     [:row, 9, [:cell, "Does Tsatsiki taste good with gyros?"], [:cell, "Yes"]]
  #   ]]
  #
  def initialize(sexp)
    @rows = read_rows(sexp[1..-1])
  end
  
  
  
  attr_reader :rows
  
  
  
  def render
    widths = calculate_column_widths
    output = ""
    rows.each do |row|
      output << "    |"
      row.each_with_index do |cell, i|
        output << " #{cell.ljust(widths[i])} |"
      end
      output << "\n"
    end
    output
  end
  
  
  
private
  
  
  
  def read_rows(sexp)
    sexp.map do |row_sexp|
      row_sexp[2..-1].map {|cell_sexp| cell_sexp[1]}
    end
  end
  
  
  
  def calculate_column_widths
    widths = []
    rows.each do |row|
      row.each_with_index do |cell, i|
        width = cell.length
        widths[i] = width if widths[i].nil? || widths[i] < width
      end
    end
    widths
  end
  
  
  
end
