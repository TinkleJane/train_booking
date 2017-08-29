namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    response = RestClient.get "http://v.juhe.cn/weather/citys", :params => { :key => "c86d4cfb37940debe0ccabd9c40023e0" }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_city = City.find_by_juhe_id(c["id"])

      if existing_city.nil?
        City.create!(:juhe_id => c["id"], :province => c["province"],
        :city => c["city"], :district => c["district"])
      end
    end
    puts "Total: #{City.count} cities"
  end
end
