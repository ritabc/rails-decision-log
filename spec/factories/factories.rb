
FactoryBot.define do

  sequence :email do |n|
    "rita#{n}@test.com"
  end

  ## Layout / Summary / Build Order:
  # NOTE: Keep this file simple, okay to repeat logic (ie. associating circles with users) in spec files
  # 1. Circle, which can exist by itself
  # 2. Decision, which must belong to a circle
  # 3. User, created without circles/roles
  # 4. Role, when created needs Circle and User

  ## Factory for Circle
  ## Factor without decisions
  factory :circle do
    name { "Land Stewardship" }
    description { "This is the description for land stewardship" }
    abbreviation { "LS "}

    ## Optional Trait: Has Decisions
    trait :with_decisions do

      # Add transient atttributes (data which aren't attributes on the model)
      # transient do
      #   decisions_count { 5 }
      # end
      decisions { create_list :decision, 5 }
    end
  end

  ## Factory for Decision, which belongs_to a Circle
  factory :decision do
    name { "Dig a well" }
    description { "We decided to dig a well, and cover it with a pump house" }
    date_decided { Date.new(2016,5,27) }
    circle
  end

  ## Factory for User type: 'leader'
  factory :leader, class: User do
    email { generate(:email) }
    first_name { "Rita" }
    last_initial { "BC" }
    password { "Pa$$word123" }
    password_confirmation { "Pa$$word123" }
    site_admin_type { "leader" }

      # before :create do |user|
      #   circles = create_list :circle, 5
      #   circles.map do |circle|
      #     circ_users = []
      #     circle.roles.each { |role| circ_users.push(role.user) }
      #     unless user.in?(circ_users)
      #       create(:role, circle: circle, user: user)
      #     end
      #   end
      # end
    # end

    ## Factory for User type: 'super'
    ## (May not be proper way to create super - will super inherit email/password attributes from leader?)
    factory :super do
      site_admin_type { "super" }
    end
  end

  # factory :role do
  #   role_type { "ol" }
  #   circle
  #   association :user, factory: :leader_with_circles
  # end

  factory :role do
    role_type { "ol" }
    circle { create :circle }
    user { create :leader }
  end

end
