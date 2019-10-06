class Application

	# @@items = ["Apples","Carrots","Pears"]
	@@items = ["Figs","Oranges"]
	@@cart = []

	def call(env)
		resp = Rack::Response.new
		req = Rack::Request.new(env)

			if req.path.match(/items/)
				@@items.each do |item|
					resp.write "#{item}\n"
				end
			elsif req.path.match(/search/)
				search_term = req.params["q"]
				resp.write handle_search(search_term)
			elsif req.path.match(/cart/)
				if @@cart.length > 0
					@@cart.each { |item| resp.write "#{item}\n" }
				else
					resp.write "Your cart is empty"
				end
			elsif req.path.match(/add/)
				search_term2 = req.params["item"]
				resp.write add_to_cart(search_term2)
			else
				resp.write "Path Not Found"
			end

		resp.finish
	end

	def handle_search(search_term)
		if @@items.include?(search_term)
			return "#{search_term} is one of our items"
		else
			return "Couldn't find #{search_term}"
		end
	end
	
	def add_to_cart(search_term2)
		if @@items.include?(search_term2)
			@@cart << search_term2
			return "added #{search_term2}"
		else
			return "We don't have that item"
		end
	end

end
