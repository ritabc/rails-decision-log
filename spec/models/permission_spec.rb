require 'rails_helper'

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    permission.allow?(*args)
  end
end

describe Permission do

  context 'User as viewer' do
    subject { Permission.new(nil) }
    it { should allow("decisions", "index") }
    it { should_not allow("decisions", "new") }
    it { should_not allow("decisions", "create") }

  end

end
