module AdsHelper

def major_currencies(hash)
  hash.inject([]) do |array, (id, attributes)|
    priority = attributes[:priority]
    if priority && priority < 10
      array[priority] ||= []
      array[priority] << id
    end
    array
  end.compact.flatten
end

# Returns an array of all currency id
def all_currencies(hash)
  hash.keys
end

def all_prices_hash(records)
  arr = Hash.new
  records.each do |t|
    if t.indicative_price_cents != 0 
      arr[t.indicative_price_cents] ||= 0
      arr[t.indicative_price_cents] = arr[t.indicative_price_cents] + 1
    end
  end
    arr
end

def all_prices(records)
  arr = []
  total = 0
  all_prices_hash = all_prices_hash(records)
  all_prices_hash_count = all_prices_hash.values.sum

  all_prices_hash.each do |key, val|
    total += val
    arr << [ key.to_f, 100 * val / all_prices_hash_count ]
  end
  arr
end
end
