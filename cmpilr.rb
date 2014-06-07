require 'sinatra'
require 'sass'
require 'haml'
require 'coffee-script'

SupportedFormats = {
  scss: 'css', 
  sass: 'css',
  haml: 'html',
  coffee: 'javascript'
}

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

set :haml, {format: :html5}

get '/' do
  haml :index, locals: { current_url: request.url }
end

get '/*/' do
  haml :upload
end

post '/*/' do
  format = params[:splat][0].to_sym
  halt "Unsupported format #{format}." unless SupportedFormats.keys.include? format
  begin
    content_type "text/#{SupportedFormats[format]}"
    render format, get_body(request), { :layout => false }
  rescue => e
    status 400
    content_type 'text/plain'
    e.message
  end
end
