module App
  module Helpers
    def today
      Time.now.strftime("%D")
    end

    def yesterday
      (Time.now - (3600 * 24)).strftime("%D")
    end
  end

  module OrderManagement
    def order(date = today)
      # Get order from DB or create if necessary
      database[:orders].first(date: today) ||
        database[:orders].insert(date: today) &&
        database[:orders].first(date: today)
    end

    def order_items(date = today)
      database[:order_items].filter(date: date).order(:dish, :user).all
    end

    def set_restaurant(restaurant)
      database[:orders].filter(date: today).update(restaurant: restaurant)
    end

    def set_items(items)
      database[:order_items].filter(date: today).delete
      database[:order_items].import(
        [:date, :user, :dish, :price, :notes],
        items.map {|item| [today, *item] })
    end
  end

  module UsersManagement
    def usernames
      database[:users].order(:name).all.map{|u| u[:name]}
    end

    def user(name)
      # Get user from DB or create if necessary
      database[:users].first(:name => name) ||
        database[:users].insert(:name => name) &&
        database[:users].first(:name => name)
    end
  end

  module RestaurantsRegister
    def update_register(restaurant, dishes_with_prices)
      database[:restaurants].insert(name: restaurant) unless database[:restaurants].first(name: restaurant)
    end

    def restaurants
      database[:restaurants].order(:name).all.map{|u| u[:name]}
    end

    def dishes(restaurant)

    end
  end
end
