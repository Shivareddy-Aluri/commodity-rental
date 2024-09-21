module Api
    class Api::CommoditiesController < ApplicationController

        before_action :check_criteria, :check_required_params, only: [:list]
        before_action :check_bid_eligibility, only: [:create_bid]

        def list
            commodity = Commodity.find_or_initialize_by(name: params[:item_name], category: params[:item_category], lender: @current_user)

            if commodity.new_record?
                commodity.assign_attributes(is_rented: false)

                if commodity.save
                    create_listing(commodity)
                else
                    render json: { status: "error", message: commodity.errors.full_messages.join(", ") }, status: :unprocessable_entity
                end
            else
                render json: { status: "error", message: "Commodity already listed" }, status: :conflict
            end
        end

        def get_list
            listings = Listing.where(is_active: true)

            if params[:item_category].present?
                listings = listings.joins(:commodity).where(commodities: { category: params[:item_category] })
            end

            payload = listings.includes(:commodity).map do |listing|
                {
                  commodity_id: listing.commodity.id,
                  created_at: listing.created_at.to_i,
                  quote_price_per_month: listing.min_monthly_rate,
                  item_category: listing.commodity.category
                }
            end

            render json: {
                status: "success",
                message: "Available commodities fetched successfully",
                payload: payload
            }, status: :ok
        end

        def create_bid
            listing = Listing.find_by(commodity_id: params[:commodity_id], is_active: true)

            unless listing
                render json: { status: "error", message: "Listing not found or inactive" }, status: :not_found
                return
            end

            if params[:bid_price_month].to_f < listing.min_monthly_rate
                render json: { status: "error", message: "Bid price must be greater than or equal to the minimum monthly rate" }, status: :unprocessable_entity
                return
            end

            bid = Bid.new(listing: listing, renter: @current_user, bid_price_month: params[:bid_price_month], lease_period: params[:rental_duration])

            if bid.save
                render json: { status: "success", message: "Bid created successfully", payload: { bid_id: bid.id, commodity_id: bid.listing.commodity.id, created_at: bid.created_at.to_i} }, status: :created
            else
                render json: { status: "error", message: bid.errors.full_messages.join(", ") }, status: :unprocessable_entity
            end
        end

        private

        def check_criteria
            if @current_user.user_type != "lender"
                render json: { status: "error", message: "Renter cannot create commodities" }, status: :unauthorized
                return false
            end
        end

        def check_bid_eligibility
            if @current_user.user_type != "renter"
                render json: { status: "error", message: "lender cannot bid" }, status: :unauthorized
                return false
            end
        end

        def check_required_params
            required_params = [:item_name, :item_category, :quote_price_per_month, :bid_strategy, :lease_period]
            missing_params = required_params.select { |param| params[param].blank? }

            if missing_params.any?
                render json: { status: "error", message: "Missing parameters: #{missing_params.join(', ')}" }, status: :unprocessable_entity
                return false
            end
        end

        def create_listing(commodity)
            listing = Listing.new(commodity: commodity, lender: commodity.lender, min_monthly_rate: params[:quote_price_per_month], lease_period: 6, bid_strategy: params[:bid_strategy], is_active: true)

            listing.expires_at = Time.now + 3.hours

            if listing.save
                render json: {
                  status: "success",
                  message: "Commodity listed successfully",
                  payload: {
                    commodity_id: listing.id,
                    quote_price_per_month: listing.min_monthly_rate,
                    created_at: listing.created_at
                  }
                }, status: :created
            else
                render json: { status: "error", message: listing.errors.full_messages.join(", ") }, status: :unprocessable_entity
            end
        end
    end    
end
