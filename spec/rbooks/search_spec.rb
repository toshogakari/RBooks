require 'spec_helper'

RSpec.describe RBooks::Search do
  it 'searches the books of its mached books' do
    stub_request(:any, 'app.rakuten.co.jp')

    search = RBooks::Search.new('sample')

    result = search.get do |params|
      params[:title] = 'Ruby'
    end

    expect(result).to eq('')
  end
end
