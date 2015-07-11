require_relative './rbooks/version'
require 'net/https'
require 'json'

module RBooks
  HOST = 'app.rakuten.co.jp'
  PATH = '/services/api/BooksBook/Search/20130522'

  class Search
    attr_accessor :params

    def initialize(app_id)
      @app_id = app_id
      @params = {}
    end

    def get
      yield @params if block_given?

      url = make_query

      http = Net::HTTP.new(HOST, 443)
      http.use_ssl = true
      req = Net::HTTP::Get.new(url)
      res = http.request(req)

      JSON.parse(res.body)
    end

    private

    def make_query
      url = PATH
      url += '?format=json'

      @params.each do |key, value|
        url += "&#{key}=#{value}"
      end

      url += "&applicationId=#{@app_id}"
    end
  end
end
