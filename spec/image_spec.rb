require 'image'

describe Image do
  before do
    @image = Image.new(5,6)
  end
  
  describe '#initialize' do
    it 'creates new image with columns and rows' do
      allow(Image).to receive(:new).with(5,6)
      expect(@image.columns).to eq 5
      expect(@image.rows).to eq 6
    end
  end

end
