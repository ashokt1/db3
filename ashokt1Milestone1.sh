#!/bin/bash
#Testing script:

#1. create 3 users

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/users -d '{"user": {"email":"tanvi.ashok@gmail.com", "name":"Tanvi Ashok", "password":"tanvi123"}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/users -d '{"user": {"email":"jane.doe@gmail.com", "name":"Jane Doe", "password":"jane123"}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/users -d '{"user": {"email":"john.smith@gmail.com", "name":"John Smith", "password":"john123"}}'

#2. create 5 splatts

#SPLATT 1:
curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Hello Splatter World, Tanvi Ashok here", "user_id":1}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Hello Splatter World, Jane Doe here", "user_id":2}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Hello Splatter World, John Smith here", "user_id":3}}'

#SPLATT 2:
curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Tanvi Ashok: This is my second splatt!", "user_id":1}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Jane Doe: This is my second splatt!", "user_id":2}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"John Smith: This is my second splatt!", "user_id":3}}'

#SPLATT 3:
curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Tanvi Ashok:  DB3 was awesome today!", "user_id":1}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Jane Doe:  DB3 was awesome today!", "user_id":2}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"John Smith: DB3 was awesome today!", "user_id":3}}'

#SPLATT 4:
curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Tanvi Ashok: There has been an Ebola virus breakout in West Africa", "user_id":1}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Jane Doe: There has been an Ebola virus breakout in West Africa", "user_id":2}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"John Smith: There has been an Ebola virus breakout in West Africa", "user_id":3}}'

#SPLATT 5:
curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Tanvi Ashok: It is a cold day in Dunedin today", "user_id":1}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"Jane Doe: It is a cold day in Dunedin today", "user_id":2}}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/splatts -d '{"splatt": {"body":"John Smith: It is a cold day in Dunedin today", "user_id":3}}'

#3. causes the first user to follow the other 2
curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/users/follows -d '{"id":1, "follows_id":2}'

curl -i -H "Content-type: application/json" -X POST http://ashok.sqrawler.com:3000/users/follows -d '{"id":1, "follows_id":3}'

#4. gets the first user's splatts
curl -i -H "Content-type: application/json" -X GET http://ashok.sqrawler.com:3000/users/splatts/1

#5. gets the users followed by the first user
curl -i -H "Content-type: application/json" -X GET http://ashok.sqrawler.com:3000/users/follows/1

#6. gets the first user's news feed
curl -i -H "Content-type: application/json" -X GET http://ashok.sqrawler.com:3000/users/splatts-feed/1

#7. causes the first user to unfollow the third user
curl -i -H "Content-type: application/json" -X DELETE http://ashok.sqrawler.com:3000/users/follows/1/3

#8. displays the first user's news feed after unfollowing the third
curl -i -H "Content-type: application/json" -X GET http://ashok.sqrawler.com:3000/users/splatts-feed/1







