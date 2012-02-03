# Submissions

![Refinery Submissions](http://refinerycms.com/system/images/BAhbBlsHOgZmSSIqMjAxMS8wNS8wMS8wNF81MF8wMV81MDlfaW5xdWlyaWVzLnBuZwY6BkVU/inquiries.png)

### Gem Installation using Bundler (The very best way)

Include the latest [gem](http://rubygems.org/gems/refinerycms-submissions) into your Refinery CMS application's Gemfile:

    gem 'akismetor', :git => 'http://github.com/jrissler/akismetor'
    gem 'refinerycms-submissions', '~> 1.1', :git => 'http://github.com/jrissler/refinerycms-submissions'

Then type the following at command line inside your Refinery CMS application's root directory:

    bundle install

#### Installation on Refinery 0.9.9 or above.

To install the migrations, run:

    rails generate refinerycms_submissions

Next migrate your database and you're done:

    rake db:migrate

## About

__Add a simple contact form to Refinery that notifies you and the customer when an submission is made.__

In summary you can:

* Collect and manage submissions
* Specify who is notified when a new submission comes in
* Customise an auto responder email that is sent to the person making the submission

## Akismet SPAM filter
to-do add content

## How do I get Notified?

Go into your 'Submissions' tab in the Refinery admin area and click on "Update who gets notified"

## How do I Edit the Automatic Confirmation Email

Go into your 'Submissions' tab in the Refinery admin area and click on "Edit confirmation email"

## How do I change the from address from no-reply@com.au to no-reply@[mydomain].com.au

Simply change the Refinery setting 'Tld Length' in the admin section from 1 to 2 and your domain name will be added.

Note: This only affects top level domains that are two deep (ie: not .com or .org, but does affect .com.au etc).
