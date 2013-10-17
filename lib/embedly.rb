class Embedly
  def initialize(url)
    @resp = Rails.cache.fetch ['embedly', url], expires_in: 1.day do
      connection.get("/1/oembed", {
        url: url,
        maxwidth: 500,
      }).body
    end
  end

  def has_html?
    if is_valid?
      @resp.has_key?("html")
    end
  end

  def method_missing(arg)
    if is_valid?
      @resp[arg.to_s] || (respond_to?(arg) ? super(arg) : nil)
    end
  end

  def is_valid?
    @resp.class == Hash
  end

  private
  def connection
    @connection ||= Faraday.new('http://api.embed.ly/') do |c|
      c.use FaradayMiddleware::ParseJson, content_type: 'application/json'
      c.params = {
        key: ENV['EMBEDLY_KEY'],
      }
      c.adapter Faraday.default_adapter
    end
  end
end
