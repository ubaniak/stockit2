class User < ActiveRecord::Base

    has_many :sales
    has_many :sale_transactions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  def validate?
      return [self.can_manage, self.can_sell, self.can_report].any?
  end
end
