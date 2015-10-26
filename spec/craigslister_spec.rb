require 'spec_helper'
require_relative '../craigslister'

RSpec.describe Craigslister, '#url' do
  it 'builds craigslist url from arguments' do
    hondas = Craigslister.new(item: 'Honda CBR')

    expect(hondas.url).to eq(
      'https://sfbay.craigslist.org/search/sss?sort=rel&query=honda+cbr')
  end

  context 'when given area argument' do
    it 'builds url with correct area' do
      harleys = Craigslister.new(area: 'austin', item: 'Harley Davidson')

      expect(harleys.url).to eq(
        'https://austin.craigslist.org/search/sss?sort=rel&query=harley+davidson')
    end
  end
end