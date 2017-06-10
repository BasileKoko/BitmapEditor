require 'image'

describe Image do
  before do
    @image = Image.new(2,3)
  end

  describe '#initialize' do
    it 'creates new image with columns and rows' do
      allow(Image).to receive(:new).with(2,3)
      expect(@image.columns).to eq 2
      expect(@image.rows).to eq 3
    end
    it 'clears table and set all pixels to white once a new image is created' do
      allow(Image).to receive(:new).with(2,3)
      expect(@image.show_image_content).to eq "O O\nO O\nO O\n"
    end
  end

  describe '#colour_pixels' do
    it 'colours pixels with given colour' do
      @image.colour_pixel(2,3,"C")
      expect(@image.show_image_content).to eq "O O\nO O\nO C\n"
    end
  end

  describe '#draw_vertical_segment' do
    it 'draws vertical segment with given colour' do
      @image.draw_vertical_segment(2,2,3,"W")
      expect(@image.show_image_content).to eq "O O\nO W\nO W\n"
    end
  end
end
