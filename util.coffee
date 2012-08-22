formatDate = (date) ->
  date = new Date(date)
  SPANISH_MONTHS = { 1: 'Ene', 2: 'Feb', 3: 'Mar', 4: 'Abr', 5: 'May', 6: 'Jun', 7: 'Jul', 8: 'Ago', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dic' }
  day   = date.getDate()
  month = SPANISH_MONTHS[date.getMonth() + 1]
  hours = date.getUTCHours()
  mins  = if date.getMinutes() >= 10 then date.getMinutes() else "0" + date.getMinutes()
  "#{day} #{month} a las #{hours}:#{mins}"

