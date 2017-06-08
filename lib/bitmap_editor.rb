
class BitmapEditor

  def run(file)
    return puts "Please provide correct file" if file.nil? || !File.exists?(file)
    parse_file(file)
  end

  def parse_file(file)
    file_content = File.read(file).split("\n")
    file_content.map { |cmd_arg| evaluate cmd_arg }
  end

  def evaluate(cmd_arg)
    cmd, *args = cmd_arg.split(' ').map { |el| el =~ /\d+/ ? el.to_i : el }

    case cmd
      when "I" then create_img(*args)
      when "L" then colour_pix(*args)
      when "V" then draw_vert(*args)
      when "H" then draw_horz(*args)
      end
  end

  def create_img(*args)
  end

  def colour_pix(*args)
  end

  def draw_vert(*args)
  end

  def draw_horz(*args)
  end
end
