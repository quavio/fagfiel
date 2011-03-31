module DeviseMacros
  def login user = nil
    before(:each) do
      sign_out :user
      sign_in user || create_user
    end
  end

  def login_as_admin
    before(:each) do
      sign_out :user
      sign_in create_user(:role => "a")
    end
  end
  
  def login_as_manager
    before(:each) do
      sign_out :user
      sign_in create_user(:role => "m")
    end
  end

  def sign_in user
    sign_out :user
    sign_in user || create_user
  end
end
