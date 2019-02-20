
FactoryBot.define do

  ## Factory for User type: 'leader'
  factory :leader, class: User do
    email { "rita@test.com" }
    first_name { "Rita" }
    last_initial { "BC" }
    password { "Pa$$word123" }
    password_confirmation { "Pa$$word123" }
    site_admin_type { "leader" }

    trait :with_many_circles do
      transient do
        circles_count { 5 }
      end
      circles { create_list :circle, circles_count }
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

    ## Trait :with_many_decisions Decisions
    trait :with_decisions do

      # Add transient atttributes (data which aren't attributes on the model)
      transient do
        decisions_count { 5 }
      end
      decisions { create_list :decision, decisions_count }
    end

  end

  ## Factory for Role type OL
  factory :lsc_ol do
    type { "operational_leader" }
  end
end
