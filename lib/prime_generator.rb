class PrimeGenerator
  def initialize
    @@primes ||= [2, 3]
  end

  include Enumerable

  def each
    @@primes.each { |p| yield p }
    next_possible = @@primes.last + 2
    loop do
      if prime?(next_possible)
        @@primes << next_possible
        yield next_possible
      end
      next_possible += 2
    end
  end

  def prime?(possible_prime)
    !@@primes.any? { |prime| (possible_prime % prime) == 0 }
  end

end
