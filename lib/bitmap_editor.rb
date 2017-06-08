
class BitmapEditor

  def run(file)
    return puts "Please provide correct file" if file.nil? || !File.exists?(file)
    parse_file(file)
  end

  def parse_file(file)
    file_content = File.read(file).split("\n")
    file_content.map { |com_arg| evaluate com_arg }
  end

  def evaluate(com_arg)
  end
end
