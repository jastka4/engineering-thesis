Future<List<CalendarEvent>> getCalendarEvents(
    DateTime first, DateTime last) async {
  String _username = await storageRepository.getUsername();
  University _university = await storageRepository.getUniversity();
  if (await ConnectionStatusSingleton.getInstance().checkConnection()) {
    List<CalendarEvent> events = await _calendarService.fetchCalendarEvents(
        _username, _university, first, last);
    _calendarDao.updateCalendarEvents(first, last, events);
    return events;
  } else {
    return _calendarDao.getCalendarEvents(first, last);
  }
}