# app/services/pokemon_card_service.rb
require 'net/http'
require 'json'

class PokemonCardService
  API_BASE_URL = 'https://api.pokemontcg.io/v2/cards'

  def self.fetch_cards_by_supertype(supertype, type = nil)
    uri = URI(API_BASE_URL)

    query = "supertype:#{supertype}"
    query += " types:#{type}" if type && supertype != 'Energy'
    query += " name:#{type}" if type && supertype == 'Energy'
    params = { q: query.strip }
    uri.query = URI.encode_www_form(params)
    # add select=id,name to the query
    uri.query += '&select=id,name,types,supertype'
    puts uri

    request = Net::HTTP::Get.new(uri)

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)['data']
  rescue JSON::ParserError, Net::HTTPError => e
    Rails.logger.error "Error fetching cards: #{e.message}"
    []
  end
end
