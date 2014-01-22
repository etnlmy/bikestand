FactoryGirl.define do
  factory :contract do
    sequence(:name) { |n| "Contract #{n}" }
    sequence(:commercial_name) { |n| "Commercial Name #{n}" }
    country_code "FR"
    cities ["Arcueil", "Aubervilliers", "Bagnolet"]
  end
end