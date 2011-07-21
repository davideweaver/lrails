module Loggr
  class LogClient
    def post(e, async = true)
      require 'net/http'
      require 'uri'
      apikey = ::Loggr::Config.api_key
      logkey = ::Loggr::Config.log_key
      uri = URI.parse("http://post.loggr.net/1/logs/#{logkey}/events")
      resp = Net::HTTP.post_form(uri, {"apikey" => apikey, "text" => e.text, "data" => e.data, "value" => e.value, "tags" => e.tags, "source" => e.source, "link" => e.link, "geo" => e.geo})
    end

    def call_remote(url, data)
      config = Loggr::Config
      optional_proxy = Net::HTTP::Proxy(config.http_proxy_host,
                                          config.http_proxy_port,
                                          config.http_proxy_username,
                                          config.http_proxy_password)
      client = optional_proxy.new(config.remote_host, config.remote_port)
      client.open_timeout = config.http_open_timeout
      client.read_timeout = config.http_read_timeout
      client.use_ssl = config.ssl?
      client.verify_mode = OpenSSL::SSL::VERIFY_NONE if config.ssl?
      begin
        response = client.post(url, data)
        case response
          when Net::HTTPSuccess
            Loggr.logger.info( "#{url} - #{response.message}")
            return true
          else
            Loggr.logger.error("#{url} - #{response.code} - #{response.message}")
        end
      rescue Exception => e
        Loggr.logger.error('Problem notifying Loggr about the error')
        Loggr.logger.error(e)
      end
      nil
    end
  end
end