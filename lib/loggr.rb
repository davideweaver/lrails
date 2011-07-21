$:.unshift File.dirname(__FILE__)

require 'loggr/monkeypatches'
require 'loggr/catcher'
require 'loggr/log_factory'
require 'loggr/config'
require 'loggr/application_environment'
require 'loggr/exception_data'
require 'loggr/controller_exception_data'
require 'loggr/rack_exception_data'
require 'loggr/alert_data'
require 'loggr/remote'
require 'loggr/integration/rack'    
require 'loggr/integration/rack_rails'
require 'loggr/version'
require 'loggr/logclient'
require 'loggr/events'

require 'loggr/railtie' if defined?(Rails::Railtie)

module Loggr
  PROTOCOL_VERSION = 5
  CLIENT_NAME = 'getloggr-gem'
  ENVIRONMENT_FILTER = []

  def self.logger
    ::Loggr::LogFactory.logger
  end

  def self.configure(api_key)
    Loggr::Config.api_key = api_key
  end

  def self.handle(exception, name=nil)
    Loggr::Catcher.handle(exception, name)
  end
  
  def self.rescue(name=nil, context=nil, &block)
    begin
      self.context(context) unless context.nil?
      block.call
    rescue Exception => e
      Loggr::Catcher.handle(e,name)
    ensure
      self.clear!
    end
  end

  def self.rescue_and_reraise(name=nil, context=nil, &block)
    begin
      self.context(context) unless context.nil?
      block.call
    rescue Exception => e
      Loggr::Catcher.handle(e,name)
      raise(e)
    ensure
      self.clear!      
    end
  end

  def self.clear!
    Thread.current[:loggr_context] = nil
  end

  def self.context(hash = {})
    Thread.current[:loggr_context] ||= {}
    Thread.current[:loggr_context].merge!(hash)
    self
  end
end