class ApiResponse
  attr_reader :total_entries
  attr_reader :data

  def initialize(arguments)
    @total_entries = arguments[:total_entries]
    @data = arguments[:data]
  end

  def to_json
    { total_entries: @total_entries, data: @data }.to_json
  end
end