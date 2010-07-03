require 'json'

class RDBI::Result::Driver::JSON < RDBI::Result::Driver
  def initialize(result, *args)
    super

    @as_object = false

    if args[0].kind_of?(Hash) 
      @as_object = args[0][:as_hash] || args[0][:as_object]
    end
  end

  def fetch(row_count)
    if @as_object
      obj_hash = { }
      index    = []
      results  = []

      @result.schema.columns.map(&:name).each { |name| index.push(name); obj_hash[name] = nil }

      @result.raw_fetch(row_count).each do |row|
        my_hash = obj_hash.dup
        row.each_with_index do |col, i|
          my_hash[index[i]] = col
        end
        results.push my_hash
      end

      return JSON.dump(results)
    else
      return JSON.dump(@result.raw_fetch(row_count))
    end
  end
end
