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

    it 'calls method parse_file when file provided exists' do
      allow(subject).to receive(:run).with(@file)
      expect(subject).to receive(:parse_file).with(@file)
      subject.parse_file(@file)
    end
  end

  describe '#parse_file' do
    it 'parses file and call method evaluate for each line' do
      dbl = ["I 5 6"]
      allow(dbl).to receive(:map) do |cmd_arg|
        expect(subject).to receive(:evaluate).with(cmd_arg)
      end
    end
  end
end
