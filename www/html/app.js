(function() { // We use this anonymous function to create a closure.

	var app = angular.module('splatter-web', ['ngResource']); //creating a module called splatter-web
	
	app.factory('User', function($resource) {
		return $resource('http://ashok.sqrawler.com/api/users/:id.json', {}, {
		update: {method:'PUT', url:'http://ashok.sqrawler.com/api/users/:id.json'},
		listSplatt: {method:'GET', url:'http://ashok.sqrawler.com/api/users/splatts-feed/:id',isArray:true},
		follow: {method:'POST', url:'http://ashok.sqrawler.com/api/users/follows.json'},
		unfollow: {method:'DELETE', url:'http://ashok.sqrawler.com/api/users/follows/:id/:follows_id'},
		splatts: {method:'GET', url:'http://ashok.sqrawler.com/api/users/splatts/:id',isArray:true},
		deleteUser: {method:'DELETE', url:'http://ashok.sqrawler.com/api/users/:id.json'}
		}
	)})	;
	
	app.factory('Splatt', function($resource) {
		return $resource('http://ashok.sqrawler.com/api/splatts/:id.json', {}, {
		save: {method:'POST', url:'http://ashok.sqrawler.com/api/splatts'}
		}
	)})	;
		
	/* attaching a controller to our module
	app.controller('UserController', function(User) {
    add your user code below
		console.log(User); 
		 this.hello = "Hello World";
		this.u = u1;
		this.feed = feed;  
		
		this.u = User.get({id:1}); //displays "Tanvi Ashok"


	 add your user code above	
	});

    add your form controller below
	app.controller('UpdateFormController', function() {
	
	this.data = {};
	
	this.updateUser = function(user) {
		user.u.name = this.data.name;
		this.data = {}; clears the form
		}

	}); 
    add your form controller above */
	
	/*  A new user shall be able to create an account */  
	app.controller('CreateNewUser', function(User) {
	
	this.data = {};
	this.createUser = function() {
	
	User.save ({user:{name: this.data.name, email: this.data.email, password: this.data.password}});
	alert ("New account created");
	this.data = {};
	}
	});	
	
	/* An existing user shall be able to "sign in" */
	app.controller('ExistingUser', function(User) {
	
	this.data = {};
	this.existingUser = function() {
	//id = this.data.id;
	password = this.data.password;
		
	this.u = User.get({id:this.data.id});
	this.data = {};
	}
	});
	
	/* An existing user shall be able to edit her name and blurb fields */
	app.controller('EditUser', function(User) {
	
	this.data = {};
	
	this.editUser = function() {
	var name = this.data.name;
	var blurb = this.data.blurb;
		
	this.u = User.get({id:this.data.id});
	this.u = User.update({id:this.data.id}, {user:{blurb:this.data.blurb, name:this.data.name}});
	this.data = {};
	}
	
	this.getUser = function() {
	User.get({id:this.data.id},function(user){
	this.data.blurb=user.blurb;
	this.data.name=user.name;
	});
	
	}
	});
	
	/* An existing user shall be able to compose and submit a new splatt */
	app.controller('ComposeAndSubmitSplatt', function(Splatt) {
	
	this.data = {};
	this.composeSplatt = function() {
	
	var body = this.data.body;
	var id = this.data.id;
	
	Splatt.save({splatt:{body:body, user_id:id}});
	this.data = {};
		
	}
	});
	
	/* An existing user shall be able to see his splatts feed  */
	app.controller('ViewSplattsFeed', function(User) {
	
	this.data = {};
	this.viewSplatt = function() {
	splatts_feed = this.data.splatts_feed;
		
	this.splatts_feed = User.listSplatt({id:this.data.id});
	this.data = {};
	}
	});
	
	/* A user whether signed in or not, shall be able to view others information and splatts  */
	app.controller('ViewInformation', function(User) {
	
	this.data = {};
	this.viewInfo = function() {
		var user_id = this.data.id;
	
		this.u = User.get({id:user_id});
		this.splatts = User.splatts({id:user_id});
		
		this.data = {};
	}
	});	
	
	/* An existing user shall be able to follow other users	 */
	app.controller('FollowUsers', function(User) {
	
	this.data = {};
	this.followUser = function() {
		var user_id = this.data.id;
		var follows_id = this.data.follows_id;
		
		 User.follow({id:user_id, follows_id:follows_id});
		
		this.data = {};
	}
	});
	
	/* An existing user shall be able to unfollow other users */
	app.controller('UnfollowUsers', function(User) {
	
	this.data = {};
	this.unfollowUser = function() {
		var user_id = this.data.id;
		var follows_id = this.data.follows_id;
		
		User.unfollow({id:user_id, follows_id:follows_id});
		
		this.data = {};
	}
	});
	
	/* An existing user shall be able to delete her account */	
	app.controller('DeleteAccount', function(User) {
	
	this.data = {};
	this.deleteUser = function() {
		var user_id = this.data.id;
		User.deleteUser({id:user_id});
		this.data = {};
	}
	}); 
	 	

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

       