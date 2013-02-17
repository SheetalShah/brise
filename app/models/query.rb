class Query < ActiveRecord::Base
  attr_accessible :message, :subject, :to

  def send_query(users, product)
    users.each do |user|
      Mailer.send("query", user.email, from, subject, message, product ).deliver
    end
  end

  def get_user_ids(users)
    ids = []
    users.each do |user|
      ids << user.id
    end
    ids
  end

  def get_user_display_names(users)
    display_names = []
    users.each do |user|
      display_names << user.display_name
    end
    display_names
  end

end

