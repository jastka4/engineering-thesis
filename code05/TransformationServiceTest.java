@SpringBootTest
class TransformationServiceTest {
    @Autowired
    TransformationService transformationService;

    private final static String REQUEST_SPEC = "[{\"operation\": \"shift\",\"spec\": {\"username\": \"user\",\"studentNumber\": \"indeks\",\"startDate\": \"date.start\",\"endDate\": \"date.end\"}}]";
    private final static String RESPONSE_SPEC = "[{\"operation\": \"shift\",\"spec\": {\"events\": {\"*\": {\"eventName\": \"events.[&1].name\",\"room\": \"events.[&1].classroom\",\"type\": \"events.[&1].eventType\",\"date\": {\"start\": \"events.[&2].startDateTime\",\"end\": \"events.[&2].endDateTime\"},\"*\": \"events.[&1].&\"}}}}]";
    private final static String ADDRESS = "http://localhost:1080/calendar";
    private final static String UNIVERSITY = "pwr";

    private final static String CALENDAR_JSON_INPUT = "{\"university\": \"pwr\",\"username\": \"pwr123456\",\"studentNumber\": \"123456\",\"startDate\": \"2020-01-01\",\"endDate\": \"2020-01-31\"}";
    private final static String CALENDAR_JSON_OUTPUT = "{\"user\":\"pwr123456\",\"indeks\":\"123456\",\"date\":{\"start\":\"2020-01-01\",\"end\":\"2020-01-31\"}}";

    private static Transformation transformation;

    @BeforeAll
    static void initAll() {
        transformation = new Transformation(UNIVERSITY, ADDRESS, REQUEST_SPEC, RESPONSE_SPEC);
    }

    @DisplayName("Test JSON transformation")
    @Test
    void transformCalendarJson() throws JSONException {
        final String output = transformationService.transformJson(new JSONObject(CALENDAR_JSON_INPUT), transformation, LoadType.REQUEST, UNIVERSITY);
        assertEquals(CALENDAR_JSON_OUTPUT, output);
    }
}