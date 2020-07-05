class DateDecidedBeforeToday < ActiveModel::Validator
  def validate(decision)
    # Because we also need to validate whether date_decided is present, rspec will at some point set date_decided to nil, in which case this will error out unless we return if it's blank
    return if decision.date_decided.blank?
    unless decision.date_decided <= Date.today
      decision.errors[:date_decided] << "Date Decided must be before today's date"
    end
  end
end
