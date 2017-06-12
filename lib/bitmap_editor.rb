
class BitmapEditor
  require_relative 'image'

  def run(file)
    return puts "Please provide correct file" if file.nil? || !File.exists?(file)
    parse_file(file)
  end

  def parse_file(file)
    file_content = File.read(file).split("\n")
    file_content.map { |line| get_command line }
  end

  def get_command(line)
    cmd, *args = line.split(' ').map { |el| (el.to_i > 0 && el.to_i < 251) ? el.to_i : el }

    case cmd.upcase
      when "I" then create_img(*args)
      when "L" then colour_pix(*args)
      when "V" then draw_vert(*args)
      when "H" then draw_horz(*args)
      when "S" then show_cont
      when "C" then clear_tbl
      else
        "Unknown command"
      end
  end

  def create_img(*args)
    @image = Image.new(*args)
  rescue ArgumentError => arg
    puts "Can't create new image with wrong number of arguments"
  end

  def colour_pix(*args)
    @image.colour_pixel(*args)
  rescue ArgumentError => arg
    puts "Can't colour pixels with wrong number of arguments"
  rescue NoMethodError => e
    puts "Can't colour pixels with invalid argument type"
  end

  def draw_vert(*args)
    @image.draw_vertical_segment(*args)
  rescue ArgumentError => arg
    puts "Can't draw vertical segment with wrong number of arguments"
  rescue NoMethodError => e
    puts "Can't draw vertical segment with invalid argument type"
  end

  def draw_horz(*args)
    @image.draw_horizontal_segment(*args)
  rescue ArgumentError => arg
    puts "Can't draw horizontal segment with wrong number of arguments"
  rescue NoMethodError => e
    puts "Can't draw horizontal segment with invalid argument type"
  end

  def show_cont
    @image.show_image_content
  rescue NoMethodError => e
    puts "No image found"
  end

  def clear_tbl
    @image.clear_table
  rescue NoMethodError => e
    puts "No table to clear"
  end
end
