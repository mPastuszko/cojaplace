module App
  module Helpers
    def today
      Time.now.strftime("%D")
    end
  end

  module OrderManagement
    def set_restaurant(restaurant)
      database[:orders].filter(date: today).update(restaurant: restaurant)
      database[:restaurants].insert(name: restaurant) unless database[:restaurants].first(name: restaurant)
    end
  end
end