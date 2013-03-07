Fabricator(:user) do
	name Faker::Name.name
	password Faker::Lorem.word
	email Faker::Internet.email
end

#Fabricator(:private_user, from: :user) do
#	is_private true
#end

Fabricator(:feed) do
	body Faker::Lorem.words(3)
end

Fabricator(:permission) do
	feed_id '1'
	user_id '1'
end
