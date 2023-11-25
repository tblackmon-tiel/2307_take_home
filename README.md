# README

## Gimme Tea (Take-Home)
This repo holds a simple API created as a mock "take home" eval going into the final mod of Turing. The purpose of the API is to allow the creation of, cancellation of, and retrieval of subscriptions of a customer to different teas. For simplicity, there is no user registration, and all data is created locally instead.

## Technologies
Primary:

- Ruby 3.2.2
- Rails 7.0.8
- PostgreSQL

Production Gems:

- jsonapi-serializer

Testing Gems:
- rspec-rails
- shoulda-matchers

## Installation/Setup
### Cloning and installing dependencies
- Fork Repository
- `git clone <repo_name>`
- `cd <repo_name>`
- `bundle install`
- `rails db:{drop,create,migrate}`

### Setting up data
The seed file already contains a small amount of test data that can be initialized with `rails db:seed`. Alternative data can be added via editing the seed file, or manual creation in the rails console (`rails c`) - both customers and teas will need to be created.

- Customers: first_name, last_name, email (unique), address
`Customer.create(first_name: "Kiwi", last_name: "Bird", email: "kiwibird@test.com", address: "1234 test ln")`

- Teas: title, description, temperature, brew_time
`Tea.create(title: "Good Tea", description: "It's just a good tea", temperature: 92, brew_time: 7)`

## Testing
There are two options for testing, either the existing test suite, or manual testing with Postman.
- Test suite: `bundle exec rspec`
- Postman: `rails s`, then test on http://localhost:3000

## Endpoints
- GET /api/v1/subscriptions?customer_id={id}
Example response:
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "First Good Tea",
                "price": 23.15,
                "status": "cancelled",
                "frequency": 30
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Second Good Tea",
                "price": 30.99,
                "status": "active",
                "frequency": 30
            }
        }
    ]
}
```
<br><br>
- POST /api/v1/subscriptions
Expected request body:
```
{
    "customer_id": <int>/<string>
    "tea_id": <int>/<string>
    "price": <float>
    "frequency": <int>
}
```

Example response:
```
{
    "success": "Subscription created successfully"
}
```
<br><br>
- PATCH /api/v1/subscriptions/{subscription_id}/cancel
Example response:
```
{
    "success": "Subscription has been successfully cancelled"
}
```

## Schema
```
ActiveRecord::Schema[7.0].define(version: 2023_11_25_201025) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "tea_id", null: false
    t.string "title"
    t.float "price"
    t.integer "frequency"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["tea_id"], name: "index_subscriptions_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "temperature"
    t.integer "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subscriptions", "customers"
  add_foreign_key "subscriptions", "teas"
end
```
