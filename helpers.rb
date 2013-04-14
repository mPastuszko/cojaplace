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

    def set_payment(payer, paid)
      database[:orders].filter(date: today).update(payer: payer, paid: paid)
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

  module RestaurantsDishesRegister
    def update_register(restaurant, dishes_with_prices)
      dishes_with_prices.each do |dish, price|
        if database[:dishes].filter(restaurant: restaurant, dish: dish).update(price: price) == 0
          database[:dishes].insert(restaurant: restaurant, dish: dish, price: price)
        end
      end
    end

    def restaurants
      database[:dishes].select(:restaurant).order(:restaurant).all.
        map(&:values).
        flatten.
        uniq
    end

    def dishes_with_prices(restaurant = nil)
      database[:dishes].
        filter(restaurant ? {restaurant: restaurant} : '').
        order(:restaurant, :dish).
        all.
        # Having array of hashes we want to convert it to hash of hashes:
        # {'restaurant name' => {'dish name' => price } }
        inject(Hash.new {|h, k| h[k] = {}}) do |result, e|
          restaurant = e[:restaurant]
          dish = e[:dish]
          price = e[:price]
          result[restaurant][dish] = price
          result
        end
    end
  end
end
