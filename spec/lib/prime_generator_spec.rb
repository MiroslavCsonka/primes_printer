require './spec/spec_helper'
require "./lib/prime_generator"

describe PrimeGenerator do

  it 'can generate 10 primes' do
    expect(PrimeGenerator.new.take(10)).to eq [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  end

end