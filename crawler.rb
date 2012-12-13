require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Crawler
    
  def initialize()
   @links_hash = {}   
  end

 def pr
   @links_hash.each {|l| p l}
   p @links_hash.size
 end

 def links(url)
    links_array = []
    uri = URI(url)
    document = Nokogiri::HTML(open(url))
    document.css('a').each do |link| 
       if(link['href'])&&(link['href'].match(/https/))
          if (!links_array.include?(link['href']))   
	     links_array << link['href']
	  end   
       else
          if (link['href'])&&(!link['href'].match(/#ja-/))
          if (link['href'])&&(!link['href'].match(/http:/))
             if (!links_array.include?(("http://"+uri.host+link['href'])))
	        links_array << "http://"+uri.host+(link['href'])
	     end
          else
	     if (!links_array.include?(link['href']))
                links_array << link['href']
	     end
          end
          end
      end
   end
   links_array
 end    

 def crawler(url, index)
     unless (index == 0)
       if (index == 1)
          unless (@links_hash.has_key?(url))  
             @links_hash [url] = links(url)
	     crawler(url, 0)
	  end
       else
          lin = links(url)
          lin.each do |l|
             unless (@links_hash.has_key?(l))
                @links_hash [l] = lin
                crawler(l, index - 1)              
             end
	  end   
       end
     end
     rescue
     @links_hash
  end  

  def control_uri(url, index)
        if (url.match(/http/))
           crawler(url, index)            
        else
           if (url.match(/www/))
              url = "http://" + url
              crawler(url,index)
           else

              url = "http://www." + url
              crawler(url, index)
           end
        end
        crawler(url, index)
   end
end 
