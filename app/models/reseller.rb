class Reseller < ActiveRecord::Base
  belongs_to :user
  belongs_to :manager, :class_name => 'User', :foreign_key => :manager_id
  validate :verify_user_is_not_manager

  def verify_user_is_not_manager
    errors.add(:manager, 'O revendedor não pode ser seu próprio gerente') if user == manager
  end

end
