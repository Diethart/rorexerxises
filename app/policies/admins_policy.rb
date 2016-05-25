class AdminsPolicy < Struct.new(:user, :admins)
  def admin?
    user.has_role? :admin
  end

  [:link?, :index?].each do |ali|
    alias_method ali, :admin?
  end
end
