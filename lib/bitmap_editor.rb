
class BitmapEditor
  require_relative 'image'

  def run(file)
    return puts 'Please provide correct file' if file.nil? || !File.exist?(file)
    parse_file(file)
  end

  def parse_file(file)
    file_content = File.read(file).split("\n")
    return puts 'Please provide file which is not empty' if file_content.empty?
    file_content.map { |line| get_command line }
  end

  def get_command(line)
    cmd, *args = line.split(' ').map { |el| el.to_i > 0 && el.to_i < 251 ? el.to_i : el }

    case cmd
    when 'I' then create_img(*args)
    when 'L' then colour_pix(*args)
    when 'V' then draw_vert(*args)
    when 'H' then draw_horz(*args)
    when 'S' then show_cont
    when 'C' then clear_tbl
    when 'D' then draw_diag(*args)
    else
      puts 'Command not found'
    end
  end

  def create_img(*args)
    @image = Image.new(*args)
  rescue ArgumentError
    puts "Can't create new image with wrong number of arguments"
  end

  def colour_pix(*args)
    @image.colour_pixel(*args)
  rescue ArgumentError
    puts "Can't colour pixels with wrong number of arguments"
  rescue NoMethodError
    puts "Can't colour pixels: no image found or invalid arguments type given"
  end

  def draw_vert(*args)
    @image.draw_vertical_segment(*args)
  rescue ArgumentError
    puts "Can't draw vertical segment with wrong number of arguments"
  rescue NoMethodError
    puts "Can't draw vertical segment: no image found or invalid arguments type given"
  end

  def draw_horz(*args)
    @image.draw_horizontal_segment(*args)
  rescue ArgumentError
    puts "Can't draw horizontal segment with wrong number of arguments"
  rescue NoMethodError
    puts "Can't draw horizontal segment: no image found or invalid arguments type given"
  end

  def draw_diag(*args)
    @image.draw_diagonal(*args)
  rescue ArgumentError
    puts "Can't draw diagonal with wring number of arguments"
  rescue NoMethodError
    puts "Can't draw diagonal: no image found or invalid arguments type given"
  end

  def show_cont
    @image.show_image_content
  rescue NoMethodError
    puts 'No image found'
  end

  def clear_tbl
    @image.clear_table
  rescue NoMethodError
    puts 'No table to clear'
  end
end
