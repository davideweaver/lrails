module Loggr
  class Events
    def self.create
      return FluentEvent.new()
    end

    def self.create_from_exception(ex, request=nil)
      ev = self.create
      ev.text(ex.message)
      ev.tags("error")
      ev.add_tags(ex.class)
      ev.data(Loggr::ExceptionData.format_exception(ex, request))
      ev.datatype(DataType::HTML)
      return ev
    end
  end

  class DataType
    HTML = 0
    PLAINTEXT = 1
  end

  class Event
    attr_accessor :text, :source, :link, :data, :value, :tags, :geo, :datatype
  end

  class FluentEvent

    def initialize()
      @event = Event.new()
    end

    def post(async = true)
      client = LogClient.new()
      client.post(@event, async)
    end

    def text(text)
      @event.text = self.assign_w_macros(text, @event.text)
      return self
    end

    def textf(fmt, *args)
      self.text(sprintf(fmt, args))
      return self
    end

    def add_text(text)
      @event.text = sprintf("%s%s", @event.text, text)
      return self
    end

    def add_textf(fmt, *args)
      self.add_text(sprintf(fmt, args))
      return self
    end

    def source(text)
      @event.source = self.assign_w_macros(text, @event.source)
      return self
    end

    def sourcef(fmt, *args)
      self.source(sprintf(fmt, args))
    end

    def link(text)
      @event.link = self.assign_w_macros(text, @event.link)
      return self
    end

    def linkf(fmt, *args)
      self.link(sprintf(fmt, args))
    end

    def data(text)
      @event.data = self.assign_w_macros(text, @event.data)
      return self
    end

    def dataf(fmt, *args)
      self.data(sprintf(fmt, args))
    end

    def add_data(text)
      @event.data = sprintf("%s%s", @event.data, text)
      return self
    end

    def add_dataf(fmt, *args)
      self.add_data(sprintf(fmt, args))
      return self
    end

    def value(val)
      @event.value = val
      return self
    end

    def value_clear()
      @event.value = nil
      return self
    end

    def tags(tags)
      @event.tags = tags
      return self
    end

    def add_tags(tags)
      @event.tags = sprintf("%s %s", @event.tags, tags)
      return self
    end

    def datatype(t)
      @event.datatype = t
      return self
    end

    def geo(lat, lon)
      @event.geo = sprintf("%d,%d", lat, lon)
      return self
    end

    def geo_ip(ip)
      @event.geo = sprintf("ip:%s", ip)
      return self
    end

    def geo_clear()
      @event.geo = nil
      return self
    end

    def assign_w_macros(input, base)
      if base.nil?
        base = ""
      end
      return input.gsub("$$", base)
    end
  end
end
