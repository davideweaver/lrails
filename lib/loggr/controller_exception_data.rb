require 'digest/md5'

module Loggr
  class ControllerExceptionData < ExceptionData
    def self.format_exception(ex, request=nil)
	  res = ""

	  # basic info
      res = res + sprintf("<b>Exception</b>: %s<br />", ex.message)
      res = res + sprintf("<b>Type</b>: %s<br />", ex.class)
      res = res + sprintf("<b>Machine</b>: %s<br />", get_hostname)
      res = res + sprintf("<b>Language</b>: %s<br />", language_version_string)
      res = res + "<br />"

	  # web details
	  if !request.nil?
	    res = res + sprintf("<b>Request URL</b>: %s<br />", (@request.respond_to?(:url) ? @request.url : "#{@request.protocol}#{@request.host}#{@request.request_uri}"))
	    res = res + "<br />"
	  end

	  # stack
      res = res + "<b>Stack Trace</b><br />"
      res = res + "<br />"
	  res = res + (ex.backtrace || []).join("<br/>")

	  return res
	end

    def self.get_hostname
      require 'socket' unless defined?(Socket)
      Socket.gethostname
    rescue
      'UNKNOWN'
    end

    def self.language_version_string
      "#{RUBY_VERSION rescue '?.?.?'} p#{RUBY_PATCHLEVEL rescue '???'} #{RUBY_RELEASE_DATE rescue '????-??-??'} #{RUBY_PLATFORM rescue '????'}"
    end

    def self.get_username
      ENV['LOGNAME'] || ENV['USER'] || ENV['USERNAME'] || ENV['APACHE_RUN_USER'] || 'UNKNOWN'
    end

    def extra_stuff                                                                                               
      return {} if @request.nil?
      {
        'request' => {
          'url' => (@request.respond_to?(:url) ? @request.url : "#{@request.protocol}#{@request.host}#{@request.request_uri}"),
          'controller' => @controller.class.to_s,
          'action' => (@request.respond_to?(:parameters) ? @request.parameters['action'] : @request.params['action']),
          'parameters' => filter_paramaters(@request.respond_to?(:parameters) ? @request.parameters : @request.params),
          'request_method' => @request.request_method.to_s,
          'remote_ip' => (@request.respond_to?(:remote_ip) ? @request.remote_ip : @request.ip),
          'headers' => extract_http_headers(@request.env),
          'session' => self.class.sanitize_session(@request)
        }
      }
    end
  end
end