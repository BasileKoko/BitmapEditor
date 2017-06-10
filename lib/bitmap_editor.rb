
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
    cmd, *args = line.split(' ').map { |el| el =~ /\d+/ ? el.to_i : el }

    case cmd
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
  end

  def colour_pix(*args)
    @image.colour_pixel(*args)
  end

  def draw_vert(*args)
    @image.draw_vertical_segment(*args)
  end

  def draw_horz(*args)
    @image.draw_horizontal_segment(*args)
  end

  def show_cont
    @image.show_image_content
  end

  def clear_tbl
    @image.clear_table
  end
end
