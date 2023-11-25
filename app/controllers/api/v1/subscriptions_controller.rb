class Api::V1::SubscriptionsController < ApplicationController
  def create
    details = JSON.parse(request.body.read, symbolize_names: true)
    tea = Tea.find_by(id: details[:tea_id])
    customer = Customer.find_by(id: details[:customer_id])

    if !tea || !customer
      render json: {errors: "Tea or customer could not be found"}, status: 404
      return
    end

    sub = Subscription.new(
      customer_id: customer.id,
      tea_id: tea.id,
      title: tea.title,
      price: details[:price],
      frequency: details[:frequency]
    )

    if sub.save
      render json: {success: "Subscription created successfully"}, status: 201
    else
      render json: {errors: sub.errors.full_messages.to_sentence}, status: 400
    end
  end

  def update
    subscription = Subscription.find_by(id: params[:subscription_id])

    if subscription
      subscription.update(status: 0)
      render json: {success: "Subscription has been successfully cancelled"}, status: 200
    else
      render json: {errors: "Subscription could not be found"}, status: 404
    end
  end
end