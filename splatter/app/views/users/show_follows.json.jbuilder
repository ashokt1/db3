json.follows @follows do |following|
	json.user do
		json.name following.name
		json.blurb following.blurb
		json.email following.email
	end
end