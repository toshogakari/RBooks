require 'spec_helper'

RSpec.describe RBooks::Search do
  it 'searches the books of its mached books' do
    canned_response = File.new('./spec/features/rakutenbooks.json')
    stub_request(:get,
      'https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522?applicationId=sample&format=json&title=%E3%81%93%E3%81%93%E3%82%8D'
                ).to_return(body: canned_response)

    search = RBooks::Search.new('sample')

    result = search.get do |params|
      params[:title] = 'こころ'
    end

    expect(2127).to eq(result['count'])
  end
end
