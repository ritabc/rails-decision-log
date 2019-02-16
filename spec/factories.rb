
FactoryBot.define do

  ## Factory for User type: 'leader'
  factory :leader, class: User do
    email { "rita@test.com" }
    first_name { "Rita" }
    last_initial { "BC" }
    password { "Pa$$word123" }
    password_confirmation { "Pa$$word123" }
    site_admin_type { "leader" }

    ## Factory for User type: 'super'
    ## (May not be proper way to create super - will super inherit email/password attributes from leader?)
    factory :super do
      site_adming_type { "super" }
    end
  end

  ## Factory for Circle
  factory :circle do
    name { "Land Stewardship" }
    description { "This is the description for land stewardship" }
  end

  ## Factory for Decision
  factory :decision do
    name { "Dig a well" }
    description { "We decided to dig a well, and cover it with a pump house" }
    date_decided { Date.new(2016,5,27) }
  end

  ## Factory for Role type OL
  factory :lsc_ol do
    type { "operational_leader" }
  end
end
