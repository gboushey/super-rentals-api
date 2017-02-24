# Super Rentals Rails API

This project contains a rails-api backend for the super-rentals tutorial on the Ember website.  I want to be clear this approach to creating a rails-api backend isn't in any way an official part of the Ember tutorial.  Instead this repository contains code and notes I figured I'd keep around in case I wanted to refer to them in the future. It could also be useful for someone learning to create a separate backend api for ember in Rails after getting started with the Ember tutorial.  

If you'd like to hook the Ember tutorial app up to this rails backend, here's what you'll need to do

1) Follow the Ember tutorial at https://guides.emberjs.com/v2.11.0/tutorial/ember-cli/, and complete it through the section on "Using Ember Data".  We'll replace Ember Mirage with a rails-api backend for development, while leaving Mirage in place for testing.

2) Once you've gotten the Ember tutorial working through Ember Data, you'll need to configure Ember not to default to Mirage in development.  To do this, open the config/environment.js file in your Ember app, and add the following code:

```
  if (environment === 'development') {
	  
    ENV['ember-cli-mirage'] = {
      enabled: false
	  }
  }
  ```
  
 3) To connect your Ember app to the rails-api backend, run 
 
 ```
 ember serve --env=proxy --proxy=localhost:3000
 ```
 
 4) To run your Ember app in test mode using Mirage, just run 
 
 ``` 
 ember test --server
 ```
 
 As usual, and your Ember app will continue to use the testing data you configured through Mirage.  
 
 ## Notes on the Rails app
 
 This rails app was created through rails-api.  There were a few alterations I had to make to get it working with Ember
 
Ember Data is expecting an api prepended with "/api", so I redirected all rails routes with api to standard resource routes in Rails.  Note: You could also handle this through an api module.
 
 ```
 match "/api/*path" => redirect("/%{path}"), via: :all
 resources :rentals
 ```
 
The ember app contains a "type" attribute for each rental to describe the type of property getting rented out (standalone, community).  Because "type" is a reserved word in rails fixtures, it was causing problems.  There are ways to deal with this, but since this is a quick exercise, I just removed it from the api.
 
 Rails-api returns lists as an array without nesting, by default.  The app created in the Ember tutorial expects them to be nested and formatted as JSON.  
 
 To get this working, I made two changes to the rails app First, I created a serializer for rentals
 
 ```
 class RentalSerializer < ActiveModel::Serializer
  attributes :id,  
    :title,
    :owner,
    :city,
    :bedrooms,
    :image,
    :description
 end
 ```
  
Next, I created an initializer named json_api.rb to ensure that serializers conform to JSON formatting
  
  ```
  ActiveSupport.on_load(:action_controller) do
    require 'active_model_serializers/register_jsonapi_renderer'
  end

  ActiveModelSerializers.config.adapter = :json_api
```

These changes are already in this repository, so you should be able to bundle rake and run and have a working rails-api backend.  

For a step-by-step on how to do this with more explanations, check out my blog post at 

https://blogs.library.ucsf.edu/ckm/2015/10/28/ember-and-rails-scaffolding-for-simple-crud/

Hope this helps!

 

 
 
 
 
