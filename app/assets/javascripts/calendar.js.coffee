Display =
  setTitle: (date)->
    title = "#{date.format('YYYY')}年#{date.format('M')}月のカレンダー"
    $("h2.title").text title
  appendTable: ->
    html = """
<table class=\"table table-bordered\">
  <thead></thead>
  <tbody></tbody>
</table>
    """
    $("div.calendar").append html
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
    html = "<td class=\"#{class_name}\">#{date.format('YYYY/M/D')}</td>"
    $("tr.calendar__week-#{week}").append html
  append_calendar: (base_date) ->
    start_date = moment(base_date).startOf("month").day(0)
    end_date = moment(base_date).endOf("month").day(6)
    total_days = end_date.diff(start_date,"days")
    weekdays = ["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"] 
    date = moment(start_date)

    $("div.calendar").empty()
    Display.setTitle(base_date)
    Display.appendTable()
    Display.appendWeekdayHeader()
  
    for weekday, index in weekdays
      Display.appendWeekday(weekday)
  
    for i in [0..total_days]
      week_num = (i // 7) + 1
      Display.appendWeek(week_num) if i % 7 == 0
      if date.format("M") is base_date.format("M")
        Display.appendDate(date, week_num, "calendar__date")
      else
        Display.appendDate(date, week_num, "calendar__out-of-date")
      date.add("days", 1)

CurrentView =
  getDate: ->
    year = $("div.calendar").attr("year")
    month = $("div.calendar").attr("month")
    date = moment(new Date(year, month - 1))  
  setDate: (date)->
    $("div.calendar").attr(
      "year": date.format("YYYY"),
      "month": date.format("M")
    )

$ ->
  Display.append_calendar(moment(new Date()))

  $('button.prev').click ->
    date = CurrentView.getDate()
    prev_date = moment(date).add("month", -1)
    CurrentView.setDate(prev_date)
    Display.append_calendar(prev_date)

  $("button.next").click ->
    date = CurrentView.getDate()
    next_date = moment(date).add("month", 1)
    CurrentView.setDate(next_date)
    Display.append_calendar(next_date)
