import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class ShopStateUAuthUser {
  ShopStateUAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<ShopStateUAuthUser> shopStateUAuthUserSubject =
    BehaviorSubject.seeded(ShopStateUAuthUser(loggedIn: false));
Stream<ShopStateUAuthUser> shopStateUAuthUserStream() =>
    shopStateUAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
