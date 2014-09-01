(function() { // We use this anonymous function to create a closure.

	var app = angular.module('splatter-web', ['ngResource']); //creating a module called splatter-web
	
	app.factory('User', function($resource) {
		return $resource('http://ashok.sqrawler.com:3000/users/:id.json');
	})	
		
	//attaching a controller to our module
	app.controller('UserController', function(User) {
    // add your user code below
	
		/* this.hello = "Hello World";
		this.u = u1;*/
		this.feed = feed; 
		
		this.u = User.get({id:1});


	// add your user code above	
	});

    // add your form controller below
	app.controller("UpdateFormController", function() {
	
	this.data = {};
	
	this.updateUser = function(user) {
		user.u.name = this.data.name;
		this.data = {}; //clears the form
		}

	});
    // add your form controller above
	
	app.controller("CreateNewUser", function(User) {
	
	this.data = {};
	this.createUser = function(user) {
		user.u.email = this.data.email;
		user.u.name = this.data.name;
		user.u.password = this.data.password;
		
		this.u = User.save({},user);
		
		this.data = {};
	}
	});
	
	app.controller("ExistingUserSignIn", function(User) {
	
	this.data = {};
	this.existingUser = function(user) {
		user.u.email = this.data.email;
		user.u.password = this.data.password;
		this.data = {};
	}
	});
	)
	
	app.controller("EditDetails", function(User) {
	
	this.data = {};
	this.existingUser = function(user) {
		user.u.email = this.data.email;
		user.u.password = this.data.password;
		this.data = {};
	}
	});
	)
	

	// mock data
        var u1 = {
          id: 1,
          name: "Jane Doe",
          email: "jane@doe.com",
          blurb: "Sometimes I feel anonymous."
	};	

        var u2 = {
          id: 2,
	  name: "Bob Smith",
	  email: "bob@smith.org"
	};

       var feed = [
         {
	   id: 3,
           user_id: 2,
           body: "This is Bob's most recent splatt.",
	   created_at: "2014-08-17T22:00:00Z"
	 },
         {
	   id: 2,
           user_id: 2,
           body: "This is Bob's second splatt.",
	   created_at: "2014-08-16T13:25:00Z"
         },
         {
	   id: 1,
           user_id: 2,
           body: "This is Bob's first splatt.",
	   created_at: "2014-08-16T10:25:00Z"
	 }
       ];
})();
