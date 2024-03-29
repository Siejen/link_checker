class SitesController < ApplicationController
  def new
  	@site = Site.new
  end

def create
  url = params.require(:site)[:url]
  site = Site.create(url: url)
  LinksWorker.perform_async(site.id)
  redirect_to site_path(site)
end

  # def create
		# require 'open-uri'
		# url = params.require(:site)[:url]
		# site = Site.create(url: url)

		# contents = Nokogiri::HTML(open(site.url))
		# contents.css('a').each do |link|
		# 	link_href = link.attributes['href'].value
		# 	if (link_href.starts_with? '/')
		# 	    link_href = site.url + link_href
		# 	end

		# 	if (link_href.starts_with? 'http://', 'https://')
		# 	    response = Typhoeus.get(link_href)

		# 	    site.links.create(url: link_href, http_response: response.response_code)
		# 	end  
	 #  end
	#   redirect_to site_path(site)
	# end

  def show
  	# id = params[:id]
  	@site = Site.find_by_id(params[:id])
  end
end