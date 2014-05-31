require 'sinatra'
require 'sass'
require 'haml'
require 'coffee-script'

Engines = {
  'scss' => {
    content_type: 'text/css',
    render: -> (content) { Sass.compile content }
  },
  'sass' => {
    content_type: 'text/css',
    render: -> (content) { Sass.compile content }
  },
  'haml' => {
    content_type: 'text/html',
    render: -> (content) { Haml::Engine.new(content).render }
  },
  'coffee' => {
    content_type: 'text/javascript',
    render: -> (content) { CoffeeScript.compile content }
  }
}.freeze

SupportedFormats = Engines.keys.freeze
  
def get_body(request)
  case request.env['CONTENT_TYPE']
  when /multipart\/form-data/i
    tmp = params["file"][:tempfile].path
    (File.read tmp)
  else 
    request.body.rewind
    request.body.read
  end
end

def render(format, content)
  engine = Engines[format]
  status 200
  content_type engine.content_type
  engine.render.call content
end

set :haml, {format: :html5}

get '/' do
  haml :index, locals: { current_url: request.url }
end

get '/*/' do
  haml :upload
end

post '/*/' do
  format = params[:splat][0]
  halt "Unsupported format #{format}." unless SupportedFormats.include? format
  begin
    render format, get_body(request)
  rescue => e
    status 400
    content_type 'text/plain'
    e.message
  end
end
