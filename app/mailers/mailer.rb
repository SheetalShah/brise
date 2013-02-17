class Mailer < ActionMailer::Base
  default from: "from@example.com"
  def query(recipient_email, from, subject, message, product, sent_at = Time.now)
    @sent_on = sent_at
    @product = product
    @from_email = from
    @message = message
    mail(:to => recipient_email, :from => from, :subject => subject, :template_name => "query", :template_path => "mailer")
  end
end
