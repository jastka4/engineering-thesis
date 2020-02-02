public String transformJson(final JSONObject jsonRequest, final Transformation transformation, final LoadType loadType, final String university) {
    final Map<String, String> inputJSON = (Map<String, String>) JsonUtils.jsonToObject(jsonRequest.toString());

    final List<Object> chainrSpecJSON;
    if (LoadType.REQUEST.equals(loadType)) {
        chainrSpecJSON = JsonUtils.jsonToList(transformation.getRequest());
    } else {
        chainrSpecJSON =
                    JsonUtils.jsonToList(transformation.getResponse());
    }
    final Chainr chainr = Chainr.fromSpec(chainrSpecJSON);

    final Object transformedOutput = chainr.transform(inputJSON);
    return JsonUtils.toJsonString(transformedOutput);
}