
FactoryBot.define do

  sequence :email do |n|
    "rita#{n}@test.com"
  end

  ## Factory for Decision, which belongs_to a Circle
  factory :decision do
    name { "Dig a well" }
    description { "We decided to dig a well, and cover it with a pump house" }
    date_decided { Date.new(2016,5,27) }
    circle
  end

  ## Factory for User type: 'leader'
  factory :leader_with_circles, class: User do
    email { generate(:email) }
    first_name { "Rita" }
    last_initial { "BC" }
    password { "Pa$$word123" }
    password_confirmation { "Pa$$word123" }
    site_admin_type { "leader" }

    # Any user must belong to at least one circle, through roles
    before :create do |user|
      circles = create_list :circle, 5
      circles.map do |circle|
        unless circle.roles.users.include?(user)
          create(:role, circle: circle, user: user)
        end
      end
    end

    ## Factory for User type: 'super'
    ## (May not be proper way to create super - will super inherit email/password attributes from leader?)
    factory :super do
      site_admin_type { "super" }
    end

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
      # transient do
      #   decisions_count { 5 }
      # end
      decisions { create_list :decision, 5 }
    end
  end

  factory :role do
    role_type { "ol" }
    circle
    association :user, factory: :leader_with_circles
  end
end
