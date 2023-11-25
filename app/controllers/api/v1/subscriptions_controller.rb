class Api::V1::SubscriptionsController < ApplicationController
  def create
    details = JSON.parse(request.body.read, symbolize_names: true)
    tea = Tea.find_by(id: details[:tea_id])
    sub = Subscription.new(
      customer_id: details[:customer_id],
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
end