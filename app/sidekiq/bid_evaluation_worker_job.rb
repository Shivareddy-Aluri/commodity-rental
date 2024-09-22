class BidEvaluationWorkerJob
  include Sidekiq::Job

  def perform(*args)
    listing = Listing.find(args[0])

    if listing.expires_at <= Time.current
      listing.update(is_active: false)
      BidSelectionService.new(listing).select_best_bid
    end
  end
end
