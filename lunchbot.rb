require 'sinatra'
require 'bundler/setup'
require 'yelp'
require 'pp'

get "/" do
  "hello"
end

get "/search/:term" do
  search_params params[:term]
  search_yelp
end

private
# Setup yelp oauth
def initialize_yelp
  Yelp::Client.new(
    { 
      consumer_key: "Y6GE7ldVFxSt6ubRSf0dhQ",
      consumer_secret: "wINEPo_icj_i2EjnOUihOoN_qNc",
      token: "G6vsN1kH0YN8OIPE2L3ux-r5JFlh1zZX",
      token_secret: "-o9dctPf7hFWQnec3fsOow4iWRk"
    })
end

def search_params term
  { 
    term: term,
    limit: 5,
    radius_filter: 9000
  }
end

def coordinates
  { latitude: 33.690175, longitude: -117.864929 }
end

def search_yelp term
  client = initialize_yelp
  parse_search_results client.search_by_coordinates coordinates, search_params
end

def parse_search_results search_results
  result_array = []
  search_results.businesses.map do |business|
    result_array.push(
      { 
        id: business.id,
        details: {
          rating: business.rating,
          name: business.name,
          url: business.url,
          review_count: business.review_count,
          phone: business.display_phone
        }
      }
    )
  end
end

def get_info
end

def get_route
end

