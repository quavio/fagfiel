# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create(:role => "a", :email => "admin@quavio.com.br", :password => "20110206", :password_confirmation => "20110206")
User.create(:role => "r", :email => "revenda@quavio.com.br", :password => "20110206", :password_confirmation => "20110206")
User.create(:role => "m", :email => "gerente@quavio.com.br", :password => "20110206", :password_confirmation => "20110206")

Reseller.create(
  :name => "Quavio", 
  :manager => User.find_by_email("gerente@quavio.com.br"), 
  :user => User.find_by_email("revenda@quavio.com.br")) if Reseller.find_by_name("Quavio").nil?
