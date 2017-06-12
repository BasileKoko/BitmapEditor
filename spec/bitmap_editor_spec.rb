require 'bitmap_editor'

describe BitmapEditor do
  before do
    @file = 'examples/show.txt'
    @image = Image.new(5,6)
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
    it 'parses file and call method get_command for each line' do
      subject.parse_file(@file)
      dbl = "I 5 6"
      expect(subject).to receive(:get_command).with(dbl)
      subject.get_command(dbl)
    end

    describe 'when command is I' do
      it 'calls method create_img' do
        cmd_arg = "I 5 6"
        allow(subject).to receive(:get_command).with(cmd_arg)
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
        line = "L 1 3 A"
        allow(subject).to receive(:get_command).with(line)
        expect(subject).to receive(:colour_pix).with(1, 3, "A")
        subject.colour_pix(1, 3, "A")
      end

      it 'calls class Image method colour_pixel' do
        allow(subject).to receive(:colour_pix).with(1,3,"A")
        expect(@image).to receive(:colour_pixel).with(1,3,"A")
        @image.colour_pixel(1,3,"A")
      end
    end

    describe 'when command is V' do
      it 'calls method draw_vert' do
        cmd_arg = "V 2 3 6 W"
        allow(subject).to receive(:get_command).with(cmd_arg)
        expect(subject).to receive(:draw_vert).with(2, 3, 6, "W")
        subject.draw_vert(2, 3, 6, "W")
      end
      it 'calls class Image method draw_vertical_segment' do
        allow(subject).to receive(:draw_vert).with(2, 3, 6, "W")
        expect(@image).to receive(:draw_vertical_segment).with(2,3,6,"W")
        @image.draw_vertical_segment(2,3,6,"W")
      end
    end

    describe 'when command is H' do
      it 'calls method draw_horz' do
        cmd_arg = "H 3 5 2 Z"
        allow(subject).to receive(:get_command).with(cmd_arg)
        expect(subject).to receive(:draw_horz).with(3, 5, 2, "Z")
        subject.draw_horz(3, 5, 2, "Z")
      end
      it 'calls class Image method draw_horizontal_segment' do
        allow(subject).to receive(:draw_horz).with(3, 5, 2, "Z")
        expect(@image).to receive(:draw_horizontal_segment).with(3,5,2,"Z")
        @image.draw_horizontal_segment(3,5,2,"Z")
      end
    end

    describe 'when command is S' do
      it 'calls method show_cont' do
        allow(subject).to receive(:get_command).with("S")
        expect(subject).to receive(:show_cont)
        subject.show_cont
      end
      it 'calls class Image method show_image_content' do
        allow(subject).to receive(:show_cont)
        expect(@image).to receive(:show_image_content)
        @image.show_image_content
      end
    end

    describe 'when command is C' do
      it 'calls method clear_tbl' do
        allow(subject).to receive(:get_command).with("C")
        expect(subject).to receive(:clear_tbl)
        subject.clear_tbl
      end
      it 'calls class Image method clear_table' do
        allow(subject).to receive(:clear_tbl)
        expect(@image).to receive(:clear_table)
        @image.clear_table
      end
    end

    describe 'when command is not recognized' do
      it 'returns unknown command message' do
        expect(subject.get_command("Z")).to eq "Unknown command"
      end
    end
  end

  describe '#create_img' do
    it 'returns an error message when creating image with wrong number of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't create new image with wrong number of arguments")
      subject.create_img(2)
    end
  end

  describe '#colour_pix' do
    before(:each) do
    subject.create_img(2,3)
    end
    it 'returns an error message when colouring pixels with wrong number of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't colour pixels with wrong number of arguments")
      subject.colour_pix(2,"W")
    end
    it 'returns an error message when colouring pixels with wrong type of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't colour pixels with invalid argument type")
      subject.colour_pix("-2",3,"W")
    end
  end

  describe '#draw_vert' do
    before(:each) do
    subject.create_img(2,3)
    end

    it 'returns an error message when drawing vertical segment with wrong number of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't draw vertical segment with wrong number of arguments")
      subject.draw_vert(2,1,3)
    end
  end
end
