# Triptionary

Hello.  Welcome to the wonderful world of Triptionary, the ultimate travel memory app.

COMING SOON - live site will be deployed at triptionary.tk

##Cloning the project

To checkout this project, get the code:

`git clone git@github.com:bwinterling/travelhub.git`

Go into the triptionary directory:

`cd travelhub`

Install all of the gems:

`bundle`

Make sure PostgreSQL is running on your local machine.  Run 'rake db:setup' and 'rake db:migrate'

Set up the APIs in your local environment (this is multi-step and requires work in the terminal):

To gather the ID and codes for each API, you must visit each site and sign up an app.  Once you have done so then you will be provided unique client ids and client secrets.  This will enable the app to be able to give users an access token when they sign in.  

`$ export CLIENT_ID`

`$ export CLIENT_SECRET`

** verify the variable names!

and finally... start the server

`rails s`

Go to 'localhost:3000' to checkout the site. 

*Project built on Rails 4.0.0, and uses Foundation*

This project was a collaboration between @MappingKat, @RolenTLe, @pzula and @TheRubeAbides - all students of [gSchool](http://gschool.it) under the teaching of @jcasimir.

The project requirements can be found here: [Feeder Engine](http://tutorials.jumpstartlab.com/projects/fourth_meal.html).

