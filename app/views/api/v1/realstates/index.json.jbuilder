json.array! @realstates do |realstate|
  json.id       realstate.id
  json.name     realstate.name
  json.category realstate.category
  json.city     realstate.city
  json.country  realstate.country
end
