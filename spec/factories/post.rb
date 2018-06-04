FactoryBot.define do
  factory :post1, :class => 'Post' do
    approved true
    title "post1"
    description "Fun"
    expire_date "22/01/2020"
    expire_time "06:10"
    offer_type "Internship"
    location "place1"
  end
  factory :post2, :class => 'Post' do
    approved true
    title "post2"
    description "Helpful"
    expire_date "22/01/2020"
    expire_time "06:10"
    offer_type "Part-Time"
    location "place2"
  end
  factory :post3, :class => 'Post' do
    approved true
    title "post3"
    description "Money"
    expire_date "23/01/2020"
    expire_time "06:10"
    offer_type "Full-Time"
    location "place3"
  end
end

