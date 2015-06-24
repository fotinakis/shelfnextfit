describe ShelfNextFit do
  it 'has a version number' do
    expect(ShelfNextFit::VERSION).not_to be nil
  end
  describe '#fits_shelves?' do
    it 'is true with 0 boxes' do
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 10,
        boxes: [],
      )
      expect(result).to eq(true)
    end
    it 'is true with 0 boxes and 0 shelves' do
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 0,
        boxes: [],
      )
      expect(result).to eq(true)
    end
    it 'is true if box is small enough' do
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 1,
        boxes: [[50, 10]],
      )
      expect(result).to eq(true)
    end
    it 'is true if box overflows the width of the shelf' do
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 1,
        boxes: [[150, 10]],
      )
      expect(result).to eq(true)
    end
    it 'is true if a box overflows the height of the shelf' do
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 1,
        boxes: [[99, 10], [150, 10]],
      )
      expect(result).to eq(true)
    end
    it 'is false with 2 boxes and 1 shelf where the first box fills the shelf' do
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 1,
        boxes: [[150, 10], [150, 10]],
      )
      expect(result).to eq(false)
    end
    it 'is false if no shelves are open' do
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 0,
        boxes: [[50, 10]],
      )
      expect(result).to eq(false)
    end
    it 'fills multiple shelves correctly' do
      boxes = [
        [100, 10],
        [100, 10],
        [100, 10],
        [50, 10],
        [50, 10],
        [50, 10],
        [50, 10],
      ]
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 5,
        boxes: boxes,
      )
      expect(result).to eq(true)

      boxes << [1, 10]
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 5,
        boxes: boxes,
      )
      expect(result).to eq(false)
    end
    it 'always fits boxes width-wise and does not account for box height' do
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 1,
        boxes: [[50, 1], [50, 1]],
      )
      expect(result).to eq(true)
      result = ShelfNextFit.fits_shelves?(
        shelf_width: 100,
        shelf_height: 10,
        num_shelves: 1,
        boxes: [[50, 1], [50, 1], [50, 1]],
      )
      expect(result).to eq(false)
    end
    it 'errors if given a box with a height greater than the shelf height' do
      expect do
        result = ShelfNextFit.fits_shelves?(
          shelf_width: 100,
          shelf_height: 10,
          num_shelves: 10,
          boxes: [[10,11]],
        )
      end.to raise_error(ArgumentError)
    end
  end
end
