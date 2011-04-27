class Notifier < ActionMailer::Base
  
  def forgot_password(user,domain)
    from "Rewriter Notifier <noreply@#{domain}>"

    @reset_password_link = reset_password_url(user.perishable_token)

    mail(:to => user.email_address_with_name,
      :subject => "Password Reset",
      :from => from,
      :fail_to => from
      ) do |format|
        format.text
    end
  end
end
