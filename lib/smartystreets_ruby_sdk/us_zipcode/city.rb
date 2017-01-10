class City
  attr_reader :mailable_city, :state_abbreviation, :state, :city

  def initialize(obj)
    @city = obj['city']
    @mailable_city = obj['mailable_city']
    @state_abbreviation = obj['state_abbreviation']
    @state = obj['state']
  end
end