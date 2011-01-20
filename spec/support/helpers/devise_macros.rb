module DeviseMacros
  def login
    before(:each) do
      sign_out :user
      sign_in create_user
    end
  end
end
