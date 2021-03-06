class Image
  attr_reader :columns, :rows, :pixels

  def initialize(columns, rows)
    @columns = columns
    @rows = rows
    clear_table
  end

  def colour_pixel(x, y, colour)
    @pixels[y - 1][x - 1] = colour if colour == colour.upcase
  end

  def draw_vertical_segment(column, start_row, end_row, colour)
    (start_row..end_row).map { |row| colour_pixel(column, row, colour) }
  end

  def draw_horizontal_segment(start_column, end_column, row, colour)
    (start_column..end_column).map { |column| colour_pixel(column, row, colour) }
  end

  def draw_diagonal(x, y, colour, length)
    (1..length + 1).map {|l| colour_pixel(l, l, colour )}
  end

  def show_image_content
    puts @pixels.map { |pix| pix.join(' ') }.join("\n") + "\n"
  end

  def clear_table
    @pixels = (1..@rows).map { (1..@columns).map { 'O' } }
  end
end
