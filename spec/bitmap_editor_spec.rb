require 'bitmap_editor'

describe BitmapEditor do
  before do
    @file = 'examples/show.txt'
  end

  describe '#get_file' do
    it "returns message to provide correct file when no file is provided" do
      expect(STDOUT).to receive(:puts).with("Please provide correct file")
      subject.run('')
    end

    it "returns message to provide correct file when file provided does not exist" do
      expect(STDOUT).to receive(:puts).with("Please provide correct file")
      subject.run('nofile.txt')
    end
  end

  describe '#parse_file' do
    before(:each) do
      @file_content = subject.parse_file(@file)
    end
    it 'returns content of the file' do
      expect(@file_content[0]).to eq 'I 5 6'
    end
  end
end
