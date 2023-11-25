require 'rails_helper'

RSpec.describe "Create Subscription", type: :request do
  describe "When I post to the /api/v1/subscriptions endpoint" do
    it "A subscription is created and I get a successful response" do
      tea = Tea.create!(title: "A Cool Tea", description: "This tea rocks", temperature: 100, brew_time: 10)
      customer = Customer.create!(first_name: "Kiwi", last_name: "Bird", email: "kiwibird@gmail.com", address: "1234 Bird Ln")
      params = {
        customer_id: customer.id,
        tea_id: tea.id,
        price: 30.20,
        frequency: 30
      }

      post "/api/v1/subscriptions", params: params, as: :json
      expect(response).to be_successful
      
      subscription = Subscription.last
      expect(subscription.customer_id).to eq(customer.id)
      expect(subscription.tea_id).to eq(tea.id)
      expect(subscription.price).to eq(params[:price])
      expect(subscription.frequency).to eq(params[:frequency])
      expect(subscription.title).to eq(tea.title)
      expect(subscription.status).to eq(1)
    end
  end
end