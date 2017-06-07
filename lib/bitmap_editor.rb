class BitmapEditor

  def get_file(file)
    return puts "Please provide correct file" if file.nil? || !File.exists?(file)
    file = gets.chomp
  end

end
