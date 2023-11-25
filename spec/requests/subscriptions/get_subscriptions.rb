require 'rails_helper'

RSpec.describe "Get Subscriptions", type: :request do
  before(:each) do
    @tea_1 = Tea.create!(title: "A Cool Tea", description: "This tea rocks", temperature: 100, brew_time: 10)
    @tea_2 = Tea.create!(title: "A Cool Tea 2", description: "This tea rocks", temperature: 100, brew_time: 10)
    @tea_3 = Tea.create!(title: "A Cool Tea 3", description: "This tea rocks", temperature: 100, brew_time: 10)
    @customer_1 = Customer.create!(first_name: "Kiwi", last_name: "Bird", email: "kiwibird@gmail.com", address: "1234 Bird Ln")
    @customer_2 = Customer.create!(first_name: "Chicken", last_name: "Bird", email: "chicken@gmail.com", address: "1234 Bird Ln")
    @sub_1 = Subscription.create!(tea_id: @tea_1.id, customer_id: @customer_1.id, title: @tea_1.title, price: 10.15, frequency: 14)
    @sub_2 = Subscription.create!(tea_id: @tea_2.id, customer_id: @customer_1.id, title: @tea_2.title, price: 20.15, frequency: 30)
    @sub_3 = Subscription.create!(tea_id: @tea_3.id, customer_id: @customer_2.id, title: @tea_3.title, price: 15.15, frequency: 14)
  end

  describe "When I make a get request to /api/v1/subscriptions with a query param of customer_id" do
    it "I get back a json object of all active and cancelled subscriptions for that customer" do
      get "/api/v1/subscriptions?customer_id=#{@customer_1.id}"
      expect(response).to be_successful

      subscriptions = JSON.parse(response.body, symbolize_names: true)
      expect(subscriptions).to be_a Hash
      expect(subscriptions).to have_key(:data)
      expect(subscriptions[:data]).to be_an Array

      subscriptions[:data].each do |subscription|
        expect(subscription).to be_a Hash
        expect(subscription).to have_key(:id)
        expect(subscription[:id]).to be_a String
        expect(subscription).to have_key(:type)
        expect(subscription[:type]).to eq("subscription")
        expect(subscription).to have_key(:attributes)
        expect(subscription[:attributes]).to be_a Hash

        attributes = subscription[:attributes]
        expect(attributes).to have_key(:title)
        expect(attributes[:title]).to be_a String
        expect(attributes).to have_key(:price)
        expect(attributes[:price]).to be_a Float
        expect(attributes).to have_key(:status)
        expect(attributes[:status]).to be_a String
        expect(attributes).to have_key(:frequency)
        expect(attributes[:frequency]).to be_an Integer
      end
    end
  end
  
  describe "sad paths" do
    it "returns an empty data object if the customer has no subscriptions" do
      customer_3 = Customer.create!(first_name: "Coco", last_name: "Bird", email: "coconut@gmail.com", address: "1234 Bird Ln")
  
      get "/api/v1/subscriptions?customer_id=#{customer_3.id}"
      expect(response).to be_successful
  
      subscriptions = JSON.parse(response.body, symbolize_names: true)
      expect(subscriptions).to be_a Hash
      expect(subscriptions).to have_key(:data)
      expect(subscriptions[:data]).to be_an Array
      expect(subscriptions[:data]).to be_empty
    end
  end
end