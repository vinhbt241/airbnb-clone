class ApplicationController < ActionController::Base
  require 'stripe'
  Stripe.api_key = ENV['stripe_api_key']
end
