require 'spec_helper'
require_relative '../craigslister'

RSpec.describe Craigslister, '#url' do
  let (:hondas) { Craigslister.new(area: 'sfbay', item: 'Honda CBR') }
  it 'builds craigslist url from arguments' do
    expect(hondas.url).to eq(
      'https://sfbay.craigslist.org/search/sss?sort=rel&query=honda+cbr')
  end
end