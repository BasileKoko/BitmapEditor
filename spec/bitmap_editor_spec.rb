require 'bitmap_editor'

describe BitmapEditor do

  describe '#get_file' do
    it "returns message to provide correct file when no file is provided" do
      expect(STDOUT).to receive(:puts).with("Please provide correct file")
      subject.get_file('')
    end

    it "returns message to provide correct file when file provided does not exist" do
      expect(STDOUT).to receive(:puts).with("Please provide correct file")
      subject.get_file('nofile.txt')
    end
  end
end
