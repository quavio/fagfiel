# coding:utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

u = User.create(:role => "a", :email => "admin@quavio.com.br", :password => "20110206", :password_confirmation => "20110206", :name => "Nícolas")
u.confirm!
u = User.create(:role => "r", :email => "nicolas.iensen@gmail.com", :password => "20110206", :password_confirmation => "20110206", :name => "Nícolas")
u.confirm!
u = User.create(:role => "m", :email => "nicolas@quavio.com.br", :password => "20110206", :password_confirmation => "20110206", :name => "Nícolas")
u.confirm!

Reseller.create(
  :name => "Quavio", 
  :manager => User.find_by_email("nicolas@quavio.com.br"), 
  :user => User.find_by_email("nicolas.iensen@gmail.com")) if Reseller.find_by_name("Quavio").nil?
