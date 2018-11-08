json.partial! @party
json.guests do
  json.array! @guests do |guest|
    json.partial! 'api/guests/guest', guest: guest
    json.gifts do
      json.array! guest.gifts do |gift|
        json.partial! 'api/gifts/gift', gift: gift
      end
    end
  end
end
