Display =
  appendWeekdayHeader: ->
    html = "<tr class=\"calendar__weekday-header\"></tr>"
    $("thead").append html
  appendWeekday: (weekday)->
    html = "<th class=\"calendar__weekday\">#{weekday}</th>"
    $("tr.calendar__weekday-header").append html
  appendWeek: (week)->
    html = "<tr class=\"calendar__week-#{week}\"></tr>"
    $("tbody").append html
  appendDate: (date, week, class_name)->
    html = "<td class=\"#{class_name}\">#{date.format('D')}</td>"
    $("tr.calendar__week-#{week}").append html

$ ->
  start_date = moment().startOf("month").day(0)
  end_date = moment().endOf("month").day(6)
  total_days = end_date.diff(start_date,"days")
  weekdays = ["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"] 

  Display.appendWeekdayHeader()

  for weekday, index in weekdays
    Display.appendWeekday(weekday)

  for i in [0..total_days]
    week_num = (i // 7) + 1
    Display.appendWeek(week_num) if i % 7 == 0
    if moment().format("M") is start_date.format("M")
      Display.appendDate(start_date, week_num, "calendar__date")
    else
      Display.appendDate(start_date, week_num, "calendar__out-of-date")
    start_date.add("days",1)
