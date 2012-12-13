require './crawler'

class App

 def call(evn)
   request = Rack::Request.new(evn)
   response = Rack::Response.new
   response['Content-Type'] = 'text/html'
   
   form = '<html>
             <head>
	       <title>Web Crawler</title>
	     </head>

	     <body>
	       <form action="/" method="post">
                   <input type="text" name="url" size="75">
		   <input type="text" name="index" size="3">
                   <input type="submit" value=":)">
	       </form>
	     </body>
            </html>'
   
   if request.post?
      craw = Crawler.new
      response.write form
      response.write craw.crawler(request.params["url"] || "http://111min.com", Integer(request.params["index"]) || 1)
      response.finish
   else
      response.write form
      response.finish
   end
 end
end
