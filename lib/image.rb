class Image
  attr_reader :columns, :rows

  def initialize(columns, rows)
    @columns, @rows = columns, rows
  end

  def colour_pixel(x, y, colour)
  end

  def draw_vertical_segment(column, start_row, end_row, colour)
  end

  def draw_horizontal_segment(row, start_column, end_column, colour)
  end

  def show_image_content
  end

  def clear_table
  end

end
