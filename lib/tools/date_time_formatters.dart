class DateTimeFormatters {
  static String tmdbDateFrom(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  DateTimeFormatters._();
}
