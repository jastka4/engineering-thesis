private String sendRequestToUniversityApi(final JSONObject request, final RequestType requestType) throws UnsupportedUniversityException {
    final String university = transformationService.getUniversity(request);
    final Optional<Transformation> transformation = transformationService.getTransformationForUniversity(university, requestType);
    
    if (transformation.isPresent()) {
        final String transformedRequest = transformationService.transformJson(request, transformation.get(), LoadType.REQUEST, university);
        final JSONObject response = requestService.sendPostRequest(transformation.get().getAddress(), transformedRequest);
        return transformationService.transformJson(response, transformation.get(), LoadType.RESPONSE, university);
    }

    throw new UnsupportedUniversityException("Missing configuration for " + university);
}