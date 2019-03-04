class DateDecidedBeforeToday < ActiveModel::Validator
  def validate(decision)
    unless decision.date_decided <= Date.today
      decision.errors[:date_decided] << "Date Decided must be before today's date"
    end
  end
end
