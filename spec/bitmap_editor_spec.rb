require 'bitmap_editor'

describe BitmapEditor do
  before do
    @file = 'examples/show.txt'
    @empty_test_file = 'examples/empty_test_file.txt'
    @image = Image.new(5, 6)
  end

  describe '#get_file' do
    it 'returns message to provide correct file when no file is provided' do
      expect(STDOUT).to receive(:puts).with('Please provide correct file')
      subject.run('')
    end

    it 'returns message to provide correct file when file provided does not exist' do
      expect(STDOUT).to receive(:puts).with('Please provide correct file')
      subject.run('nofile.txt')
    end

    it 'calls method parse_file when file provided exists' do
      allow(subject).to receive(:run).with(@file)
      expect(subject).to receive(:parse_file).with(@file)
      subject.parse_file(@file)
    end
  end

  describe '#parse_file' do
    it 'parses file and calls method get_command for each line' do
      subject.parse_file(@file)
      line = 'I 5 6'
      expect(subject).to receive(:get_command).with(line)
      subject.get_command(line)
    end

    it 'returns message to provide file which is not empty' do
      expect(STDOUT).to receive(:puts).with('Please provide file which is not empty')
      subject.run(@empty_test_file)
    end
  end

  describe '#get_command' do
    describe 'when command is I' do
      it 'calls method create_img' do
        line = 'I 5 6'
        allow(subject).to receive(:get_command).with(line)
        expect(subject).to receive(:create_img).with(5, 6)
        subject.create_img(5, 6)
      end

      it 'method create_img creates new instance of class Image' do
        allow(subject).to receive(:create_img).with(5, 6)
        expect(Image).to receive(:new).with(5, 6)
        Image.new(5, 6)
      end
    end

    describe 'when command is L' do
      it 'calls method colour_pix' do
        line = 'L 1 3 A'
        allow(subject).to receive(:get_command).with(line)
        expect(subject).to receive(:colour_pix).with(1, 3, 'A')
        subject.colour_pix(1, 3, 'A')
      end

      it 'calls method colour_pixel from class Image' do
        allow(subject).to receive(:colour_pix).with(1, 3, 'A')
        expect(@image).to receive(:colour_pixel).with(1, 3, 'A')
        @image.colour_pixel(1, 3, 'A')
      end
    end

    describe 'when command is V' do
      it 'calls method draw_vert' do
        line = 'V 2 3 6 W'
        allow(subject).to receive(:get_command).with(line)
        expect(subject).to receive(:draw_vert).with(2, 3, 6, 'W')
        subject.draw_vert(2, 3, 6, 'W')
      end

      it 'calls method draw_vertical_segment from class Image' do
        allow(subject).to receive(:draw_vert).with(2, 3, 6, 'W')
        expect(@image).to receive(:draw_vertical_segment).with(2, 3, 6, 'W')
        @image.draw_vertical_segment(2, 3, 6, 'W')
      end
    end

    describe 'when command is H' do
      it 'calls method draw_horz' do
        line = 'H 3 5 2 Z'
        allow(subject).to receive(:get_command).with(line)
        expect(subject).to receive(:draw_horz).with(3, 5, 2, 'Z')
        subject.draw_horz(3, 5, 2, 'Z')
      end

      it 'calls method draw_horizontal_segment from class Image' do
        allow(subject).to receive(:draw_horz).with(3, 5, 2, 'Z')
        expect(@image).to receive(:draw_horizontal_segment).with(3, 5, 2, 'Z')
        @image.draw_horizontal_segment(3, 5, 2, 'Z')
      end
    end

    describe 'when command is S' do
      it 'calls method show_cont' do
        allow(subject).to receive(:get_command).with('S')
        expect(subject).to receive(:show_cont)
        subject.show_cont
      end

      it 'calls method show_image_content from class Image' do
        allow(subject).to receive(:show_cont)
        expect(@image).to receive(:show_image_content)
        @image.show_image_content
      end
    end

    describe 'when command is C' do
      it 'calls method clear_tbl' do
        allow(subject).to receive(:get_command).with('C')
        expect(subject).to receive(:clear_tbl)
        subject.clear_tbl
      end

      it 'calls method clear_table from class Image' do
        allow(subject).to receive(:clear_tbl)
        expect(@image).to receive(:clear_table)
        @image.clear_table
      end
    end

    describe 'when command is D' do
      it 'calls method draw_diag'do
      allow(subject).to receive(:get_command).with('D')
      expect(subject).to receive(:draw_diag)
      subject.draw_diag
      end

      it 'calls method draw_diagonal from class Image' do
        allow(subject).to receive(:draw_diag)
        expect(@image).to receive(:draw_diagonal)
        @image.draw_diagonal(1, 2, "A", 2)
      end
    end

    describe 'when command is unknown' do
      it 'returns command not found message' do
        expect(STDOUT).to receive(:puts).with('Command not found')
        subject.get_command('Z')
      end
    end
  end

  describe '#create_img' do
    it 'returns an error message for wrong number of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't create new image with wrong number of arguments")
      subject.create_img(2)
    end
  end

  describe '#colour_pix' do
    before(:each) do
      subject.create_img(2, 3)
    end

    it 'returns an error message for wrong number of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't colour pixels with wrong number of arguments")
      subject.colour_pix(2, 'W')
    end

    it 'returns an error message for no image found or invalid argument type' do
      expect(STDOUT).to receive(:puts).with("Can't colour pixels: no image found or invalid arguments type given")
      subject.colour_pix('-2', 3, 'W')
    end

    it 'does not colour pixels when colour name is lowercase' do
      expect(STDOUT).to receive(:puts).with("O O\nO O\nO O\n")
      subject.colour_pix(2, 3, 'w')
      subject.show_cont
    end
  end

  describe '#draw_vert' do
    before(:each) do
      subject.create_img(2, 3)
    end

    it 'returns an error message for wrong number of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't draw vertical segment with wrong number of arguments")
      subject.draw_vert(2, 1, 3)
    end

    it 'returns an error message for no image found or wrong type of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't draw vertical segment: no image found or invalid arguments type given")
      subject.draw_vert('0', '', '-2', 'Z')
    end
  end

  describe '#draw_horz' do
    before(:each) do
      subject.create_img(3, 4)
    end
    it 'returns an error message for wrong number of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't draw horizontal segment with wrong number of arguments")
      subject.draw_horz(1, 2, 3)
    end

    it 'returns an error message for no image found or wrong type of arguments' do
      expect(STDOUT).to receive(:puts).with("Can't draw horizontal segment: no image found or invalid arguments type given")
      subject.draw_horz(1, 2, '-3', 'W')
    end
  end

  describe '#show_cont' do
    before do
      subject.create_img(3, '-2')
    end

    it 'returns an error message for no image' do
      expect(STDOUT).to receive(:puts).with('No image found')
      subject.show_cont
    end
  end

  describe '#clear_tbl' do
    before do
      subject.create_img(3, '-2')
    end

    it 'returns an error message for no table' do
      expect(STDOUT).to receive(:puts).with('No table to clear')
      subject.clear_tbl
    end
  end
end
