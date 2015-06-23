class TablePrinter
  def initialize(data, options = {})
    @data = data
    @horizontal_headings = options.fetch(:heading, [])
    @side_headings = options.fetch(:side_heading, [])
    @extra_spaces = options.fetch(:extra_spaces, 2)
  end

  def print
    body = @data.map.with_index { |row, row_index| "#{side_heading_for(row_index)}#{print_values(row)}" }
    (heading + body).join("\n")
  end

  private

  def side_heading?
    @side_headings.any?
  end

  def side_heading_for(row_index)
    side_heading? ? "#{adjust_padding(@side_headings[row_index], 0)}|" : ''
  end

  def heading
    if @horizontal_headings.any?
      corner_space = side_heading? ? "#{' ' * column_width(0)}|" : ''
      ["#{corner_space}#{print_values(@horizontal_headings)}", line_separator]
    else
      []
    end
  end

  def line_separator
    left_horizontal_heading = side_heading? ? ('-' * column_width(0) + '+') : '-'
    right_horizontal_heading = '-' * (0...@horizontal_headings.length).map { |index| column_width(index) }.reduce(0, &:+)
    "#{left_horizontal_heading}#{right_horizontal_heading}"
  end

  def print_values(values)
    values.map.with_index { |value, column_index| adjust_padding(value, column_index) }.join('')
  end

  def adjust_padding(value, column_index)
    value.to_s.rjust(column_width(column_index), ' ')
  end

  def column_width(column_index)
    table_widths[column_index] + @extra_spaces
  end

  def table_widths
    num_of_columns = [@horizontal_headings.length, @data.first.to_a.length].max
    @table_widths ||= num_of_columns.times.map.with_index { |_, column_index| widest_value(column_index).to_s.length }
  end

  def widest_value(column_index)
    slice_column(column_index).max_by { |val| val.to_s.length }
  end

  def slice_column(column_index)
    ([@horizontal_headings] + @data).map { |row| row[column_index] }
  end
end
