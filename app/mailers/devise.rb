class DeviseMailer < Devise::Mailer

  def confirmation_instructions(record)
    Devise::Mailer.delay.confirmation_instructions(record)
  end

  def reset_password_instructions(record)
    Devise::Mailer.delay.reset_password_instructions(record)
  end

  def unlock_instructions(record)
   Devise::Mailer.delay.unlock_instructions(record)
  end
end