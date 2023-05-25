// cache?
// app preferences??
// notifications?
// location?

import 'package:sitter_swipe/models/user_data.dart';

class ThisUser {
  final String? uid;
  final UserData? userData; // TODO: add access to this user's data?
  ThisUser({this.uid, this.userData});
}

ThisUser? globalThisUser;
// TODO: put this user's data into App Preferences
