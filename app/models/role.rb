class Role < ApplicationRecord
  belongs_to :circle
  belongs_to :user
end
