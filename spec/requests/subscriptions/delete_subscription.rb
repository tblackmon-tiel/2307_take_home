require 'rails_helper'

RSpec.describe "Delete/Cancel Subscription", type: :request do
  before(:each) do
    @tea = Tea.create!(title: "A Cool Tea", description: "This tea rocks", temperature: 100, brew_time: 10)
    @customer = Customer.create!(first_name: "Kiwi", last_name: "Bird", email: "kiwibird@gmail.com", address: "1234 Bird Ln")
  end

  describe "When a user sends a DELETE request to /api/v1/subscriptions/{id}" do
    it "the requested subscription is cancelled" do
      subscription = Subscription.create!(tea_id: @tea.id, customer_id: @customer.id, title: @tea.title, price: 100.10, frequency: 7)
      expect(subscription).to be_a Subscription
      expect(subscription.status).to eq("active")
      expect(subscription.tea_id).to eq(@tea.id)
      expect(subscription.customer_id).to eq(@customer.id)
      expect(subscription.title).to eq(@tea.title)
      expect(subscription.price).to eq(100.10)
      expect(subscription.frequency).to eq(7)

      delete "/api/v1/subscriptions/#{subscription.id}"
      expect(response).to be_successful

      subscription = Subscription.last
      expect(subscription.status).to eq("cancelled")
      expect(subscription.tea_id).to eq(@tea.id)
      expect(subscription.customer_id).to eq(@customer.id)
      expect(subscription.title).to eq(@tea.title)
      expect(subscription.price).to eq(100.10)
      expect(subscription.frequency).to eq(7)
    end
  end

  describe "sad paths" do
    it "returns an appropriate error if the subscription doesnt exist" do
      delete "/api/v1/subscriptions/101278390"
      expect(response).to_not be_successful

      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to be_a Hash
      expect(error).to have_key(:errors)
      expect(error[:errors]).to eq("Subscription could not be found")
    end
  end
end