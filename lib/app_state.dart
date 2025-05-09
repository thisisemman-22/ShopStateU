import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _bearerToken = prefs.getString('ff_bearerToken') ?? _bearerToken;
    });
    _safeInit(() {
      _userID = prefs.getInt('ff_userID') ?? _userID;
    });
    _safeInit(() {
      _PersistUserId = prefs.getInt('ff_PersistUserId') ?? _PersistUserId;
    });
    _safeInit(() {
      _persistFullName =
          prefs.getString('ff_persistFullName') ?? _persistFullName;
    });
    _safeInit(() {
      _persistEmail = prefs.getString('ff_persistEmail') ?? _persistEmail;
    });
    _safeInit(() {
      _persistPassword =
          prefs.getString('ff_persistPassword') ?? _persistPassword;
    });
    _safeInit(() {
      _persistCollege = prefs.getString('ff_persistCollege') ?? _persistCollege;
    });
    _safeInit(() {
      _persistProfilePicture =
          prefs.getString('ff_persistProfilePicture') ?? _persistProfilePicture;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _emailCreateAccount = '';
  String get emailCreateAccount => _emailCreateAccount;
  set emailCreateAccount(String value) {
    _emailCreateAccount = value;
  }

  double _sellingPrice = 0.0;
  double get sellingPrice => _sellingPrice;
  set sellingPrice(double value) {
    _sellingPrice = value;
  }

  List<String> _productImagesAdd = [];
  List<String> get productImagesAdd => _productImagesAdd;
  set productImagesAdd(List<String> value) {
    _productImagesAdd = value;
  }

  void addToProductImagesAdd(String value) {
    productImagesAdd.add(value);
  }

  void removeFromProductImagesAdd(String value) {
    productImagesAdd.remove(value);
  }

  void removeAtIndexFromProductImagesAdd(int index) {
    productImagesAdd.removeAt(index);
  }

  void updateProductImagesAddAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    productImagesAdd[index] = updateFn(_productImagesAdd[index]);
  }

  void insertAtIndexInProductImagesAdd(int index, String value) {
    productImagesAdd.insert(index, value);
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
  }

  String _bearerToken = '';
  String get bearerToken => _bearerToken;
  set bearerToken(String value) {
    _bearerToken = value;
    prefs.setString('ff_bearerToken', value);
  }

  int _userID = 0;
  int get userID => _userID;
  set userID(int value) {
    _userID = value;
    prefs.setInt('ff_userID', value);
  }

  String _searchQueryOrCategory = '';
  String get searchQueryOrCategory => _searchQueryOrCategory;
  set searchQueryOrCategory(String value) {
    _searchQueryOrCategory = value;
  }

  int _productIdCurrent = 0;
  int get productIdCurrent => _productIdCurrent;
  set productIdCurrent(int value) {
    _productIdCurrent = value;
  }

  String _whomToSendName = '';
  String get whomToSendName => _whomToSendName;
  set whomToSendName(String value) {
    _whomToSendName = value;
  }

  int _whomToSendId = 0;
  int get whomToSendId => _whomToSendId;
  set whomToSendId(int value) {
    _whomToSendId = value;
  }

  int _PersistUserId = 0;
  int get PersistUserId => _PersistUserId;
  set PersistUserId(int value) {
    _PersistUserId = value;
    prefs.setInt('ff_PersistUserId', value);
  }

  String _persistFullName = '';
  String get persistFullName => _persistFullName;
  set persistFullName(String value) {
    _persistFullName = value;
    prefs.setString('ff_persistFullName', value);
  }

  String _persistEmail = '';
  String get persistEmail => _persistEmail;
  set persistEmail(String value) {
    _persistEmail = value;
    prefs.setString('ff_persistEmail', value);
  }

  String _persistPassword = '';
  String get persistPassword => _persistPassword;
  set persistPassword(String value) {
    _persistPassword = value;
    prefs.setString('ff_persistPassword', value);
  }

  String _persistCollege = '';
  String get persistCollege => _persistCollege;
  set persistCollege(String value) {
    _persistCollege = value;
    prefs.setString('ff_persistCollege', value);
  }

  String _persistProfilePicture = '';
  String get persistProfilePicture => _persistProfilePicture;
  set persistProfilePicture(String value) {
    _persistProfilePicture = value;
    prefs.setString('ff_persistProfilePicture', value);
  }

  int _openedID = 0;
  int get openedID => _openedID;
  set openedID(int value) {
    _openedID = value;
  }

  String _openedName = '';
  String get openedName => _openedName;
  set openedName(String value) {
    _openedName = value;
  }

  String _openedDescription = '';
  String get openedDescription => _openedDescription;
  set openedDescription(String value) {
    _openedDescription = value;
  }

  String _openedCategory = '';
  String get openedCategory => _openedCategory;
  set openedCategory(String value) {
    _openedCategory = value;
  }

  double _openedPrice = 0.0;
  double get openedPrice => _openedPrice;
  set openedPrice(double value) {
    _openedPrice = value;
  }

  String _openedSellerName = '';
  String get openedSellerName => _openedSellerName;
  set openedSellerName(String value) {
    _openedSellerName = value;
  }

  String _openedSellerCollege = '';
  String get openedSellerCollege => _openedSellerCollege;
  set openedSellerCollege(String value) {
    _openedSellerCollege = value;
  }

  int _openeduserIdSeller = 0;
  int get openeduserIdSeller => _openeduserIdSeller;
  set openeduserIdSeller(int value) {
    _openeduserIdSeller = value;
  }

  String _openedPostedDate = '';
  String get openedPostedDate => _openedPostedDate;
  set openedPostedDate(String value) {
    _openedPostedDate = value;
  }

  List<String> _openedImagesPath = [];
  List<String> get openedImagesPath => _openedImagesPath;
  set openedImagesPath(List<String> value) {
    _openedImagesPath = value;
  }

  void addToOpenedImagesPath(String value) {
    openedImagesPath.add(value);
  }

  void removeFromOpenedImagesPath(String value) {
    openedImagesPath.remove(value);
  }

  void removeAtIndexFromOpenedImagesPath(int index) {
    openedImagesPath.removeAt(index);
  }

  void updateOpenedImagesPathAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    openedImagesPath[index] = updateFn(_openedImagesPath[index]);
  }

  void insertAtIndexInOpenedImagesPath(int index, String value) {
    openedImagesPath.insert(index, value);
  }

  String _whomToSendProfilePicture = '';
  String get whomToSendProfilePicture => _whomToSendProfilePicture;
  set whomToSendProfilePicture(String value) {
    _whomToSendProfilePicture = value;
  }

  String _editName = '';
  String get editName => _editName;
  set editName(String value) {
    _editName = value;
  }

  String _editDescription = '';
  String get editDescription => _editDescription;
  set editDescription(String value) {
    _editDescription = value;
  }

  String _editCategory = '';
  String get editCategory => _editCategory;
  set editCategory(String value) {
    _editCategory = value;
  }

  double _editPrice = 0.0;
  double get editPrice => _editPrice;
  set editPrice(double value) {
    _editPrice = value;
  }

  int _editProdId = 0;
  int get editProdId => _editProdId;
  set editProdId(int value) {
    _editProdId = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
