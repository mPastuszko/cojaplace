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

    def set_order(items)
      database[:order_items].filter(date: today).delete
      database[:order_items].import(
        [:date, :user, :dish, :price, :notes],
        items.map {|item| [today, *item] })
    end
  end
end