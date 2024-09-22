class BidSelectionService
    def initialize(listing)
      @listing = listing
    end
  
    def select_best_bid
      bids = Bid.where(listing: @listing)
      return nil if bids.empty?
  
      best_bid = bids.max_by do |bid|
        case @listing.bid_strategy

        when 'highest_monthly'
          bid.bid_price_month
        when 'highest_overall'
          bid.bid_price_month * bid.lease_period
        end
      end
  
      create_rental(best_bid) if best_bid
      mark_as_rented
    end
  
    private
  
    def create_rental(best_bid)
      Rental.create(commodity: @listing.commodity, listing: @listing, renter: best_bid.renter, accepted_bid: best_bid, start_date: Time.current, end_date: Time.current + best_bid.lease_period.months, monthly_rate: best_bid.bid_price_month, lease_period: best_bid.lease_period)
    end

    def mark_as_rented
        commodity = @listing.commodity
        commodity.is_rented = true
        commodity.save!
    end
end
  