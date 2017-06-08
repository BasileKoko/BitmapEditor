
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

    case cmd.upcase
      when "I" then create_img(*args)
      end
  end

  def create_img(*args)
  end

end
