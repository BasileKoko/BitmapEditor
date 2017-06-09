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
      subject.parse_file(@file)
      dbl = "I 5 6"
      expect(subject).to receive(:evaluate).with(dbl)
      subject.evaluate(dbl)
    end

    describe 'when command is I' do
      it 'calls method create_img' do
        cmd_arg = "I 5 6"
        allow(subject).to receive(:evaluate).with(cmd_arg)
        expect(subject).to receive(:create_img).with(5,6)
        subject.create_img(5,6)
      end

      it 'method create_img creates new instance of class Image' do
        allow(subject).to receive(:create_img).with(5,6)
        expect(Image).to receive(:new).with(5,6)
        Image.new(5,6)
      end
    end

    describe 'when command is L' do
      it 'calls method colour_pix' do
        cmd_arg = "L 1 3 A"
        allow(subject).to receive(:evaluate).with(cmd_arg)
        expect(subject).to receive(:colour_pix).with(1, 3, "A")
        subject.colour_pix(1, 3, "A")
      end
    end

    describe 'when command is V' do
      it 'calls method draw_vert' do
        cmd_arg = "V 2 3 6 W"
        allow(subject).to receive(:evaluate).with(cmd_arg)
        expect(subject).to receive(:draw_vert).with(2, 3, 6, "W")
        subject.draw_vert(2, 3, 6, "W")
      end
    end

    describe 'when command is H' do
      it 'calls method draw_horz' do
        cmd_arg = "H 3 5 2 Z"
        allow(subject).to receive(:evaluate).with(cmd_arg)
        expect(subject).to receive(:draw_horz).with(3, 5, 2, "Z")
        subject.draw_horz(3, 5, 2, "Z")
      end
    end

    describe 'when command is S' do
      it 'calls method show_cont' do
        allow(subject).to receive(:evaluate).with("S")
        expect(subject).to receive(:show_cont)
        subject.show_cont
      end
    end

    describe 'when command is C' do
      it 'calls method clear_tbl' do
        allow(subject).to receive(:evaluate).with("C")
        expect(subject).to receive(:clear_tbl)
        subject.clear_tbl
      end
    end

    describe 'when command is not recognize' do
      it 'return unknown command message' do
        expect(subject.evaluate("Z")).to eq "Unknown command"
      end
    end
  end
end
