@override
Widget build(BuildContext context) {
  final AuthenticationBloc _authenticationBloc =
      BlocProvider.of<AuthenticationBloc>(context);

  return Scaffold(
    appBar: _buildAppBar(_authenticationBloc),
    body: Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(child: _buildProfileInfo(_authenticationBloc))
            ]),
            Row(children: <Widget>[Expanded(child: _buildNewsFeed(context))]),
          ],
        ),
      ),
    ),
  );
}