module Loggr
  class LogClient
    def post(e, async = true)
      require 'net/http'
      require 'uri'
      logkey = ::Loggr::Config.log_key
      uri = URI.parse("http://post.loggr.net/1/logs/#{logkey}/events")
	  params = create_params(e)
      resp = Net::HTTP.post_form(uri, params)
    end

	def create_params(e)
      apikey = ::Loggr::Config.api_key
	  params = {"apikey" => apikey, "text" => e.text}
	  params = params.merge({"link" => e.link}) if !e.link.nil?
	  params = params.merge({"tags" => e.tags}) if !e.tags.nil?
	  params = params.merge({"source" => e.source}) if !e.source.nil?
	  params = params.merge({"geo" => e.geo}) if !e.geo.nil?
	  params = params.merge({"value" => e.value}) if !e.value.nil?
	  if e.datatype == DataType::HTML
	    params = params.merge({"data" => sprintf("@html\r\n%s", e.data)}) if !e.data.nil?
	  else
	    params = params.merge({"data" => e.data}) if !e.data.nil?
	  end
	  return params
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