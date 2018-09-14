FactoryBot.define do
  factory :user do
    email("test@rita.com")
    password("password")
    password_confirmation "password"
  end
end
