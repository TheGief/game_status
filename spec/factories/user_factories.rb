FactoryGirl.define do

  factory :han_solo, class: User do
    username 'HanSolo'
    phone '7075554444'
    email 'han.solo@gmail.com'
    password '<12-Parsecs!'
  end

end
