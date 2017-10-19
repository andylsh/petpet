require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  pending "add some scenarios (or delete) #{__FILE__}"

  describe "the signin process" do
  before :each do
    @user = User.create(first_name: "Zar" ,last_name: "Zar",phone_number: "0123456789" ,address1: "12 Jalan Mewah", address2: "Mewah Jaya", city: "Mewah" , state: "KL", postcode: "57100", email: "zar@gmail.com", password: "password", password_confirmation: "password" ,role: 0 )
  end

  it "signs me in" do
    visit sign_in_path
    within("#sessions") do
      fill_in 'email', with: 'zar@gmail.com'
      fill_in 'password', with: 'password'
    end
    click_button 'Sign In'
    visit root_path
    expect(page).to have_content "Logged in as #{@user.first_name}"
    expect(page).to have_content 'Welcome To PetPet'
    # expect(page).to have_selector ".alert", text: "Login successfully"
  end


  end
  
  
end


