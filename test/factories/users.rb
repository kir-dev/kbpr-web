FactoryBot.define do
  factory :user do
    name { 'Teszt User' }
    email { 'teszt@user.com' }
    authsch_id { 'random_12345' }

    factory :admin_user do
      admin { true }
    end
  end
end
