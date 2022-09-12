class PropertyPolicy < ApplicationPolicy
  def show? 
    user.has_role?(:admin) || record.owner.id == current_user.id 
  end

  def update? 
    user.has_role?(:admin) || record.owner.id == current_user.id 
  end
end
