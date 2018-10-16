export default {
  init() {
    $.extend(jQuery.timeago.settings.strings, {
      strings: '1 minute',
      hour: '1 hour',
      day: '1 day',
      hours: "%d hours",
      month: '1 month',
      year: '1 year',
      inPast: 'seconds',
      seconds: 'seconds',
      minute: '1 minute',
      week: 'week',
      weeks: 'weeks',
      months: 'months',
      months: '%d months',
      years: '%d years'
    })

    jQuery.timeago.settings.en_abbrevStrings = $.extend({}, jQuery.timeago.settings.strings)

    $.extend(jQuery.timeago.settings.en_abbrevStrings, {
      suffixAgo: '',
      hour: '1h',
      day: '1d',
      hours: "%dh",
      month: '1M',
      year: '1y',
      inPast: 'pre',
      seconds: '%ds',
      minute: '1m',
      minutes: '%dm',
      days: '%dd',
      week: '1w',
      weeks: '%dw',
      month: '1M',
      months: '%dM',
      years: '%dy'
    })

    jQuery.timeago.settings.refreshMillis = 12000
  },

  load() {
    $("time.timeago").timeago()
  }
}