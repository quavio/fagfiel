module DeviseMacros
  def login user = nil
    before(:each) do
      sign_out :user
      sign_in user || create_user
    end
  end
end
