FactoryBot.define do
  factory :user do
    email("rita@test.com")
    password("Pa$$word123")
    password_confirmation("Pa$$word123")
    admin_type("admin")

  # factory :circle do
  #   name("Land Stewardship")
  #   description("This is the description for land stewardship")
  #   factory :decision do
  #     circle
  #     name("Dig a well")
  #     description("We decided to dig a well, and cover it with a pump house")
  #     date_decided(Date.new(2016,5,27))
  #   end
  end
end
