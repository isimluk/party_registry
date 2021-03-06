json.payment do
  json.region_id @person.domestic_region_id
  json.id @person.id
  json.name @person.name
  json.street @person.domestic_address_street
  json.city @person.domestic_address_city
  json.zip @person.domestic_address_zip
  json.email @person.email
  json.membership_type @person.membership_type
  json.date_of_birth @person.date_of_birth
  if @person.is_member?
    note = "Členský příspěvek - #{@person.name}"
  else
    note = "Příspěvek příznivce - #{@person.name}"
  end
  json.accounting_note note
end
