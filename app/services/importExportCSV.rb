require "csv"

class ImportExportCSV    

    def to_csv
        attributes = %w{id name description price location_city location_state location_country }
        columns = %w{id name description price city state country }
        CSV.generate(headers: true) do |csv|
          csv << columns
      
          Product.all.each do |product|
            # csv << product.attributes.values_at(*attributes)
            csv << attributes.map{ |col|  product.send(col)}
          end
        end
      end


      def import(file)
        CSV.foreach(file.path, headers: true) do |row|
          product_hash = row.to_hash
          @prod = Product.create!(name:product_hash['name'], description: product_hash['description'], price: product_hash['price'], user_id:2 , brand_id: 2)
          @loc = @prod.build_location(postalCode: product_hash['postalCode'])
          @loc.city = City.find_by(cityName:product_hash['city'])
          @loc.state = State.find_by(stateName:product_hash['state'])
          @loc.country = Country.find_by(countryName:product_hash['country'])
          @loc.save
          
       end
      end

end