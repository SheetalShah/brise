class Comment < ActiveRecord::Base
  attr_accessible :description, :indicative_options, :indicative_price_cents, :match_price, :currency
  belongs_to :ad, :inverse_of => :comments, :touch => true
    def display_name
      ad.display_name if ad
    end

  belongs_to :user
    def display_name
      user.display_name if user
    end
     
  validates_presence_of :ad
  validates_presence_of :description  
  
  monetize :indicative_price_cents
#composed_of :pricemoney,
 #             :class_name => 'Money',
 #             :mapping => %w(indicative_price cents, currency currency),
 #             :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : Money.empty }


end
