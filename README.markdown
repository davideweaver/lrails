# Loggr <http://loggr.net>

Loggr helps you track errors in your Ruby apps

This Gem/Plugin posts exception data to Loggr <http://loggr.net>. Data about the request, session, environment and a backtrace of the exception is sent.

## Rails 2.x Installation

1.  Install the Gem
    
    ```
    $ gem install loggr
    ```
    
2.  Add config.gem entry to 'config/environment.rb'
    
    ```ruby
    config.gem 'loggr'
    ```
    
3.  Create your account and app at <http://getloggr.com>
    
4.  Configue your API Key
    
    ```
    $ loggr install <api-key>
    ```
    
    using the api-key from the app settings screen within Loggr

5.  Test with <code>loggr test</cocde>
    
## Rails 3 Installation

1.  Add  gem entry to Gemfile
    
    ```ruby
    config.gem 'loggr'
    ```
    
2.  Run <code>bundle install</code>

3.  Create your account and app at <http://getloggr.com>

4.  Configue your API Key
    
    ```
    $ loggr install <api-key>
    ```
    
    using the api-key from the app settings screen within Loggr

5.  Test with <code>loggr test</code>


### Loggr also supports your rack, sinatra and plain ruby apps
For more information check out our docs site <http://docs.getloggr.com>

Copyright © 2008, 2010 Contrast.
