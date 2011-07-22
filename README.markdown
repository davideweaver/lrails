## Ruby Loggr Agent

This Gem/Plugin posts events and exception data to Loggr <http://loggr.net>. Includes a fluent interface to posting events.

Before installing this gem/plugin, be sure to sign up for a free Loggr account and log at <http://loggr.net>

## Installation
### Install in your Rails 3 app

1. Configure your Gemfile

	```
	gem 'loggr'
	```

2. Run Bundler
	
	```
	bundle install
	```

3. Generate the Loggr config file (config/loggr.yml)

	*If you are using bundler:*

	```
	$ bundle exec loggr install YOUR-LOG-KEY YOUR-API-KEY
	```

	*If you are not using bundler:*

	```
	$ loggr install YOUR-LOG-KEY YOUR-API-KEY
	```

	You will find the LOG_KEY and API_KEY in the apps settings popup within Loggr.

4. Test everything is working

	```
	$ loggr test
	```

	You will see a test event in your Loggr log

### Install in your Rails 2 app

1. Install the loggr gem

	```
	$ gem install loggr
	```

2. Configure your environment.rb file
	
	```
	config.gem 'loggr'
	```

3. Generate the Loggr config file (config/loggr.yml)

	```
	$ loggr install YOUR-LOG-KEY YOUR-API-KEY
	```

	You will find the LOG_KEY and API_KEY in the apps settings popup within Loggr.

4. Delete the old Exceptional Plugin (if installed)

	```
	$ rm -rf vendor/plugins/loggr
	```

5. Test everything is working

	```
	$ loggr test
	```

	You will see a test event in your Loggr log

### Install in your Rack app

1. Install the loggr gem

	```
	$ gem install loggr
	```

2. Configure your config.ru file

	```
	require 'loggr'
	use Rack::Loggr, LOG-KEY, API_KEY
	```

	You will find the LOG_KEY and API_KEY in the apps settings popup within Loggr.

3. Ensure Loggr for Rack is being loaded

	Check log/loggr.log log file

### Install in your Sinatra app

1. Install the loggr gem

	```
	$ gem install loggr
	```

2. Configure your Sinatra app's environment

	```
	require 'loggr'
	use Rack::Loggr, LOG-KEY, API_KEY
	```

	You will find the LOG_KEY and API_KEY in the apps settings popup within Loggr.

3. Ensure :raise_errors is set to true

	```
	set :raise_errors, true
	```

4. Ensure Loggr for Sinatra is being loaded

	Check log/loggr.log log file

### Install in your Ruby app

1. Install the loggr gem

	```
	$ gem install loggr
	```

2. Generate the Loggr config file (config/loggr.yml)

	*If you are using bundler:*

	```
	$ bundle exec loggr install YOUR-LOG-KEY YOUR-API-KEY
	```

	*If you are not using bundler:*

	```
	$ loggr install YOUR-LOG-KEY YOUR-API-KEY
	```

	You will find the API_KEY in the apps settings screen within Exceptional.

3. Require the Exceptional gem in your ruby code

	```
	require 'rubygems'
	require 'exceptional'
	```

4. Configure Loggr for your ruby app

	```
	Loggr::Config.load("config/loggr.yml")
	```

4. Use Loggr block to catch exceptions in your ruby code in different ways

	```
	$ loggr test
	```

	You will see a test event in your Loggr log

5. Use Loggr blocks to catch exceptions in your ruby code in different ways

	```
	Loggr.rescue do
	  # Exceptions inside this block will be reported to loggr.net
	end

	Loggr.rescue_and_reraise do
	  # Exceptions will be reported to loggr.net and then
	  # re-raised to your ruby code
	end
	```

## How To Use

Here's some sample code to get you started...

### Post events

Post a simple event

	```
	Loggr::Events.create() \
		.text("This is a simple event") \
		.post()
	```

A more complex example

	```
	Loggr::Events.create() \
        .text("More complex event") \
        .link("http://loggr.net") \
        .tags("tag1 tag2") \
        .source(current_user) \
        .value(35.50) \
        .dataf("<b>user-agent:</b> %s<br/><b>on:</b> %s", r.UA, today) \
        .datatype(Loggr::DataType.HTML) \
        .geo(40.1203, -76.2944) \
        .post()

### Exceptions

Easily post a Ruby exception

	```
	Loggr::Events.create_from_exception(ex, request).post()
	```

Or add your own details to the exception

	```
	Loggr::Events.create_from_exception(ex, request) \
		.text("This was an error: $$") \
		.source("myapp") \
		.add_tags("critical") \
		.geo_ip("234.56.32.112") \
		.post()
	```

## More Information
For more information check out our docs site <http://docs.loggr.net>

