# require "rails_helper"

# RSpec.describe UserMailer, type: :mailer do
#   describe "password_reset" do
#     let(:user) { create :leader }
#     let(:mail) { UserMailer.password_reset(user) }
    
#     it "send user password reset url" do
#       expect(mail.subject).to eq("Common Ground Decision Log Password Reset")
#       binding.pry
#       expect(mail.to).to eq(user.email)
#       expect(mail.from).to eq(["
#         hartsmillecovillage@gmail.com"])
#       user.password_reset_token = "anything"
#       expect(mail.body.encoded).to eq(edit_password_resets_path(user.password_reset_token))
#     end
#   end

# end
