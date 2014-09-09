(function() { // We use this anonymous function to create a closure.

	var app = angular.module('splatter-web', ['ngResource']); //creating a module called splatter-web
	
	app.factory('User', function($resource) {
		return $resource('http://ashok.sqrawler.com/api/users/:id.json');
	})	
		
	//attaching a controller to our module
	app.controller('UserController', function(User) {
    // add your user code below
		//console.log(User); 
		/* this.hello = "Hello World";
		this.u = u1;
		this.feed = feed;  */
		
		this.u = User.get({id:1}); //displays "Tanvi Ashok"


	// add your user code above	
	});

    // add your form controller below
	app.controller('UpdateFormController', function() {
	
	this.data = {};
	
	this.updateUser = function(user) {
		user.u.name = this.data.name;
		this.data = {}; //clears the form
		}

	});
    // add your form controller above
		
	app.controller('ExistingUserSignIn', function(User) {
	
	this.data = {};
	this.existingUser = function() {
		//id = this.data.id;
		password = this.data.password;
		
		this.u = User.get({id:this.data.id});
		this.data = {};
		}
	});	
		
	app.controller('CreateNewUser', function(User) {
	
	this.data = {};
	this.createUser = function() {
		
		user = new User ({name: this.data.name, email: this.data.email, password: this.data.password});
		user.$save();
		user.u.email = this.data.email;
		user.u.name = this.data.name;
		user.u.password = this.data.password;
		
		this.u = User.save({},user);
		 
		this.data = {};
	}
	});
	/*	
	app.controller('EditDetails', function(User) {
	
	this.data = {};
	this.editDetails = function() {
		user.u.name = this.data.name;
		user.u.blurb = this.data.blurb;
		this.data = {};
	}
	});
	
	app.controller('ComposeAndSubmitSplatt', function(User) {
	
	this.data = {};
	this.composeSplatt = function() {
		user.u.body = this.data.body;
		this.data = {};
	}
	});
	
	app.controller('ViewSplattsFeed', function(User) {
	
	this.data = {};
	this.viewSplatt = function() {
		this.data.splatts-feed = user.u.splatts-feed;
		this.u = User.get({id:1, splatts-feed}); 
		this.data = {};
	}
	});
	
	app.controller('ViewInformation', function(User) {
	
	this.data = {};
	this.viewInfo = function() {
		user.u.sp = this.data.splatts-feed
		this.u = User.get({id, splatts-feed}); 
		this.data = {};
	}
	});
	
	app.controller('FollowAndUnfollowUsers', function(User) {
	
	this.data = {};
	this.followUser = function() {
		this.data = {};
	}
	});
	
	app.controller('DeleteAccount', function(User) {
	
	this.data = {};
	this.followUser = function() {
		this.data = {};
	}
	}); */ 
	 	

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
