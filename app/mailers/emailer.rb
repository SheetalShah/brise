class Emailer < ActionMailer::Base
  default from: "from@example.com"
  def query_supplier(recipient, subject, message, from, sent_at = Time.now)
    @subject = subject
    @recipients = recipient
    @from = from
    @sent_on = sent_at
      @body["title"] = 'This is title'
      @body["email"] = 'sender@yourdomain.com'
      @body["message"] = message
    @headers = {}
    mail(:to => @recipients, :from => @from, :mail => @body)
  end
end
