# VR Reality games for kids

The idea of this project was to build a platform with VR. Virtual Reality games with an approach on early childhood development. 

This project was built in Rails 5, and the games that are inside of it where built in React VR 1.4. 
The integration process as it wasn’t a available in web-pack, we integrate the  VR projects as a library in the Rails web app. 

These two apps communicate within each other with an api call that sends the score of the game to the database. 

To create this api, the app passes the date of the current user in the url, and the VR games send back the information of the session of the current user to the database.  
