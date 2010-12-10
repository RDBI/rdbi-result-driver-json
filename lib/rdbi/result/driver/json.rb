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

      if [:first, :last].include?(row_count)
        my_hash = obj_hash.dup
        @result.raw_fetch(row_count)[0].each_with_index do |col, i|
          my_hash[index[i]] = col
        end
        return ::JSON.dump(my_hash)
      else
        @result.raw_fetch(row_count).each do |row|
          my_hash = obj_hash.dup
          row.each_with_index do |col, i|
            my_hash[index[i]] = col
          end
          results.push my_hash
        end

        File.open('/tmp/foo', 'w') << results.inspect
        return ::JSON.dump(results)
      end

    else
      if [:first, :last].include?(row_count)
        return ::JSON.dump(@result.raw_fetch(row_count)[0])
      else
        return ::JSON.dump(@result.raw_fetch(row_count))
      end
    end
  end
end
