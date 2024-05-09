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
    uri.query += '&select=id,name,types,supertype,subtype,level,images,hp'

    # strategy to get faster response => get only 1 card and see the totalcount
    # then set the page size to ~40 and select a random page (to accomodate for the Trainers)
    test_uri = uri.dup
    test_uri.query += '&pageSize=1'
    puts test_uri
    request_test = Net::HTTP::Get.new(test_uri)

    response_test = Net::HTTP.start(test_uri.host, test_uri.port, use_ssl: true) do |http|
      http.request(request_test)
    end

    total_count = JSON.parse(response_test.body)['totalCount']
    number_of_pages = (total_count / 40.0).ceil
    random_page = rand(1..number_of_pages)
    uri.query += "&pageSize=40&page=#{random_page}"
    puts uri
    # the improved request
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
