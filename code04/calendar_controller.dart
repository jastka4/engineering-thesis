@PostMapping(value = "/calendar")
public ResponseEntity<String> getCalendarEvents(@RequestBody final String request) {
    try {
        return ResponseEntity.ok().body(sendRequestToUniversityApi(new JSONObject(request), RequestType.CALENDARS));
    } catch (UnsupportedUniversityException e) {
        return ResponseEntity.badRequest().body(e.getMessage());
    }
}