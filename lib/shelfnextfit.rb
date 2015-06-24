require 'shelfnextfit/version'

module ShelfNextFit
  # @param [Integer] shelf_width The fixed width of each shelf.
  # @param [Integer] shelf_height The fixed height of each shelf.
  # @param [Integer] num_shelves The number of shelves.
  # @param [Array] boxes An array of arrays containing [width, height] pairs. Should be sorted
  #   by width before being given for "optimal" behavior.
  def self.fits_shelves?(shelf_width:, shelf_height:, num_shelves:, boxes:)
    num_open_shelves = num_shelves
    shelf_width_used = 0
    boxes.each do |width, height|
      raise ArgumentError if height > shelf_height
      return false if num_open_shelves == 0

      # Modified algorithm: box always fits on shelf, no matter its width, if the shelf is open.
      shelf_width_used += width

      if shelf_width_used >= shelf_width
        # Filled the remainder of the shelf width.
        num_open_shelves -= 1
        shelf_width_used = 0
      end
    end
    true
  end
end
