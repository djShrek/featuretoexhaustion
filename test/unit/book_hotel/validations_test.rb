require "test_helper"
require "away/exceptions"
require "away/services/book_hotel"

module Away
  module BookHotelTests
    class BookHotelTest < MiniTest::Test
      def setup 
        @hotel = create(:hotel_with_extras, name: "Sheraton NY")
        @extras = @hotel.extras
        @data = {
          name: "Jose Mota",
          credit_card_number: "0000 0000 0000 0000",
          credit_card_expires_at: {
          year: 2015,
          month: 05
          }
        }
        @date = Time.new(2014, 12, 31)
      end

      def test_fails_to_book_with_no_hotel
        @service = BookHotel.new nil, @extras, @data, @date
        refute @service.execute 
      end

      def test_rails_to_book_with_no_date
        @service = BookHotel.new @hotel, @extras, @data, nil
        refute @service.execute
      end

      def test_fails_if_name_isnt_provided
        @data.delete :name
        @service = BookHotel.new @hotel, @extras, @data, @date
        refute @service.execute
      end

      def test_fails_if_the_hotel_has_no_rooms_for_that_date
        @hotel.room_count = 0
        @hotel.save

        @service = BookHotel.new @hotel, @extras, @data, @date
        refute @service.execute
      end
    end
  end
end