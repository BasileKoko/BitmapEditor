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
end
