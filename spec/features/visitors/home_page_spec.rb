# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see a form where i can type in my zip code
  scenario 'visit the home page' do
    visit root_path
    expect(page).to have_content 'Welcome'
  end

end
