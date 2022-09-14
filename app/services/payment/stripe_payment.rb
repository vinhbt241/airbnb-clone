class Payment::StripePayment
  def self.checkout_reservation(args)
    args[:user].set_payment_processor :stripe
    args[:user].payment_processor.customer 

    checkout_session = args[:user].payment_processor.checkout(
      mode: "payment",
      line_items: [{
        price: "#{args[:property].price_id}", 
        quantity: args[:date_range]
      }],
      metadata: args[:metadata],
      success_url: "http://localhost:3000#{args[:success_path]}",
      cancel_url: "http://localhost:3000#{args[:cancel_path]}"
    )

    return checkout_session
  end
end
