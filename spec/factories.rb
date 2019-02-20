
FactoryBot.define do

  sequence :email do |n|
    "rita#{n}@test.com"
  end

  ## Factory for User type: 'leader'
  factory :leader, class: User do
    email { generate(:email) }
    first_name { "Rita" }
    last_initial { "BC" }
    password { "Pa$$word123" }
    password_confirmation { "Pa$$word123" }
    site_admin_type { "leader" }

    # Ability for user to have many circles, through roles
    trait :with_many_circles do
      after :create do |leader|
        circles = create_list :circle, 5
        circles.map do |circle|
          create(:role, circle: circle, user: leader)
        end
        leader.circles = circles
      end
    end

    ## Factory for User type: 'super'
    ## (May not be proper way to create super - will super inherit email/password attributes from leader?)
    factory :super do
      site_admin_type { "super" }
    end

  end

  ## Factory for Decision, which belongs_to a Circle
  factory :decision do
    name { "Dig a well" }
    description { "We decided to dig a well, and cover it with a pump house" }
    date_decided { Date.new(2016,5,27) }
    circle
  end

  ## Factory for Circle (both with and without associated Decisions)
  ## Factor without associated decision
  factory :circle do
    name { "Land Stewardship" }
    description { "This is the description for land stewardship" }
    abbreviation { "LS "}

    ## Trait :with_many_decisions Decisions
    trait :with_decisions do

      # Add transient atttributes (data which aren't attributes on the model)
      transient do
        decisions_count { 5 }
      end
      decisions { create_list :decision, decisions_count }
    end
  end

  factory :role do
    role_type { "Operational Leader" }
    circle
    association :user, factory: :leader
  end
end
