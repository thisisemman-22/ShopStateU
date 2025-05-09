import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _bearerToken =
          await secureStorage.getString('ff_bearerToken') ?? _bearerToken;
    });
    await _safeInitAsync(() async {
      _userID = await secureStorage.getInt('ff_userID') ?? _userID;
    });
    await _safeInitAsync(() async {
      _PersistUserId =
          await secureStorage.getInt('ff_PersistUserId') ?? _PersistUserId;
    });
    await _safeInitAsync(() async {
      _persistFullName = await secureStorage.getString('ff_persistFullName') ??
          _persistFullName;
    });
    await _safeInitAsync(() async {
      _persistEmail =
          await secureStorage.getString('ff_persistEmail') ?? _persistEmail;
    });
    await _safeInitAsync(() async {
      _persistPassword = await secureStorage.getString('ff_persistPassword') ??
          _persistPassword;
    });
    await _safeInitAsync(() async {
      _persistCollege =
          await secureStorage.getString('ff_persistCollege') ?? _persistCollege;
    });
    await _safeInitAsync(() async {
      _persistProfilePicture =
          await secureStorage.getString('ff_persistProfilePicture') ??
              _persistProfilePicture;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

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
    secureStorage.setString('ff_bearerToken', value);
  }

  void deleteBearerToken() {
    secureStorage.delete(key: 'ff_bearerToken');
  }

  int _userID = 0;
  int get userID => _userID;
  set userID(int value) {
    _userID = value;
    secureStorage.setInt('ff_userID', value);
  }

  void deleteUserID() {
    secureStorage.delete(key: 'ff_userID');
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
    secureStorage.setInt('ff_PersistUserId', value);
  }

  void deletePersistUserId() {
    secureStorage.delete(key: 'ff_PersistUserId');
  }

  String _persistFullName = '';
  String get persistFullName => _persistFullName;
  set persistFullName(String value) {
    _persistFullName = value;
    secureStorage.setString('ff_persistFullName', value);
  }

  void deletePersistFullName() {
    secureStorage.delete(key: 'ff_persistFullName');
  }

  String _persistEmail = '';
  String get persistEmail => _persistEmail;
  set persistEmail(String value) {
    _persistEmail = value;
    secureStorage.setString('ff_persistEmail', value);
  }

  void deletePersistEmail() {
    secureStorage.delete(key: 'ff_persistEmail');
  }

  String _persistPassword = '';
  String get persistPassword => _persistPassword;
  set persistPassword(String value) {
    _persistPassword = value;
    secureStorage.setString('ff_persistPassword', value);
  }

  void deletePersistPassword() {
    secureStorage.delete(key: 'ff_persistPassword');
  }

  String _persistCollege = '';
  String get persistCollege => _persistCollege;
  set persistCollege(String value) {
    _persistCollege = value;
    secureStorage.setString('ff_persistCollege', value);
  }

  void deletePersistCollege() {
    secureStorage.delete(key: 'ff_persistCollege');
  }

  String _persistProfilePicture = '';
  String get persistProfilePicture => _persistProfilePicture;
  set persistProfilePicture(String value) {
    _persistProfilePicture = value;
    secureStorage.setString('ff_persistProfilePicture', value);
  }

  void deletePersistProfilePicture() {
    secureStorage.delete(key: 'ff_persistProfilePicture');
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

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
