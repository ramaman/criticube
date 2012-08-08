class CanonicalRedirect
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    if request.host =~ /^criticube.com/
      [301, {"Location" => request.url.sub("//", "//www.")}, self]
    else
      @app.call(env)
    end
  end

  def each(&block)
  end
end