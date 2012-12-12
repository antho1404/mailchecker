# Mailchecker

Simply validate your email in 3 steps using Mail-checker web service (http://www.mail-checker.com).
- Validate the format of your email
- Validate if the domain is responding 
- Validate if the email is not a temporary mail (like yopmail or others...)

This will be very helpful when you have to contact your users and you want to avoid errors causing lack of communication or want to block "spamboxes"

## Installation

Add this line to your application's Gemfile:

    gem 'mailchecker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailchecker

## Usage

Register your application in Mail-checker.com (http://www.mail-checker.com/apps/new).
Generate the config file for the gem

    $ rails generate mailchecker:install
    
Update the file (config/initializers/mailchecker.rb) with the values of your registered application (token and domain)

Now you have two ways to do the validation:

On the server side: 

Add in your model the validation of your attribute for the email (hopefully email)
    
    class User < ActiveRecord::Base
      mailchecker :email
    end

On the client side:

Call the javascript lib on your email fields and do the stuff you need on the generated file

    $ rails generate mailchecker:assets

Of course you can do the validation on the both side if you want

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
