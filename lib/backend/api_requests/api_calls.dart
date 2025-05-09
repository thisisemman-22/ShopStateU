import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start User Accounts Group Code

class UserAccountsGroup {
  static String getBaseUrl() =>
      'https://shopstateu-89a3d63aed8a.herokuapp.com/api/users';
  static Map<String, String> headers = {};
  static UserLoginCall userLoginCall = UserLoginCall();
  static UserRegistrationCall userRegistrationCall = UserRegistrationCall();
  static GetUserProfileCall getUserProfileCall = GetUserProfileCall();
}

class UserLoginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) async {
    final baseUrl = UserAccountsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'User Login',
      apiUrl: '${baseUrl}/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'email': email,
        'password': password,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? userID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.userId''',
      ));
  String? bearerToken(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));
  int? expiresAt(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.expiresAt''',
      ));
}

class UserRegistrationCall {
  Future<ApiCallResponse> call({
    String? fullName = '',
    String? email = '',
    String? password = '',
    String? college = '',
    FFUploadedFile? profilePicture,
  }) async {
    final baseUrl = UserAccountsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'User Registration',
      apiUrl: '${baseUrl}/register',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'fullName': fullName,
        'email': email,
        'password': password,
        'college': college,
        'profilePicture': profilePicture,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? userID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? fullName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.fullName''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  String? password(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.password''',
      ));
  String? college(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.college''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.createdAt''',
      ));
  dynamic profilePicture(dynamic response) => getJsonField(
        response,
        r'''$.profilePicture''',
      );
}

class GetUserProfileCall {
  Future<ApiCallResponse> call({
    int? userID,
    String? bearerToken = '',
  }) async {
    final baseUrl = UserAccountsGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Get User Profile',
      apiUrl: '${baseUrl}/profile?id=${userID}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? userID(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  String? fullName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.fullName''',
      ));
  String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  String? password(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.password''',
      ));
  String? college(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.college''',
      ));
  String? createdAt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.createdAt''',
      ));
  String? profilePictureLink(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.profilePicture''',
      ));
}

/// End User Accounts Group Code

/// Start Products Group Code

class ProductsGroup {
  static String getBaseUrl({
    String? bearerToken = '',
  }) =>
      'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products';
  static Map<String, String> headers = {
    'Authentication': 'Bearer [bearerToken]',
  };
}

/// End Products Group Code

class GetAllProductsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get All Products',
      apiUrl: 'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? productId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? productName(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? category(dynamic response) => (getJsonField(
        response,
        r'''$[:].category''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<double>? price(dynamic response) => (getJsonField(
        response,
        r'''$[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<String>? sellerName(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? sellerCollege(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerCollege''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? userId(dynamic response) => (getJsonField(
        response,
        r'''$[:].userId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? postedDate(dynamic response) => (getJsonField(
        response,
        r'''$[:].postedDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? imagePath(dynamic response) => (getJsonField(
        response,
        r'''$[:].imagePath''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class AddProductCall {
  static Future<ApiCallResponse> call({
    String? productName = '',
    String? description = '',
    String? category = '',
    double? price,
    String? sellerName = '',
    String? sellerCollege = '',
    int? userId,
    List<FFUploadedFile>? imagesList,
    String? bearerToken = '',
  }) async {
    final images = imagesList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'Add Product',
      apiUrl: 'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        'name': productName,
        'description': description,
        'category': category,
        'price': price,
        'sellerName': sellerName,
        'sellerCollege': sellerCollege,
        'userId': userId,
        'images': images,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateProductCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    int? productId,
    String? productName = '',
    String? description = '',
    String? category = '',
    double? price,
    int? userId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Update Product',
      apiUrl: 'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        'id': productId,
        'name': productName,
        'description': description,
        'category': category,
        'price': price,
        'userId': userId,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProductsByCategoryCall {
  static Future<ApiCallResponse> call({
    String? category = '',
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Products By Category',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products/category?category=${category}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? productIds(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? productNames(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? description(dynamic response) => (getJsonField(
        response,
        r'''$[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? categories(dynamic response) => (getJsonField(
        response,
        r'''$[:].category''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<double>? prices(dynamic response) => (getJsonField(
        response,
        r'''$[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List? imagePaths(dynamic response) => getJsonField(
        response,
        r'''$[:].imagePaths''',
        true,
      ) as List?;
  static List<String>? sellerName(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? sellerCollege(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerCollege''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? userId(dynamic response) => (getJsonField(
        response,
        r'''$[:].userId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? postedDate(dynamic response) => (getJsonField(
        response,
        r'''$[:].postedDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class SearchProductsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? searchQuery = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Search Products',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products/search?query=${searchQuery}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? productId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? productNameLegit(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? productDescription(dynamic response) => (getJsonField(
        response,
        r'''$[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? productCategory(dynamic response) => (getJsonField(
        response,
        r'''$[:].category''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<double>? productPrice(dynamic response) => (getJsonField(
        response,
        r'''$[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<String>? sellerName(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? sellerCollege(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerCollege''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? userIdSeller(dynamic response) => (getJsonField(
        response,
        r'''$[:].userId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? postedDate(dynamic response) => (getJsonField(
        response,
        r'''$[:].postedDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? imagePaths(dynamic response) => (getJsonField(
        response,
        r'''$[:].imagePath''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetProductDetailsNoImageCall {
  static Future<ApiCallResponse> call({
    int? productId,
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Product Details No Image',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products/${productId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? errorMessage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
  static int? productId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? productName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  static String? productDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  static String? productCategory(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.category''',
      ));
  static double? productPrice(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.price''',
      ));
  static String? sellerName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.sellerName''',
      ));
  static String? sellerCollege(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.sellerCollege''',
      ));
  static int? userId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.userId''',
      ));
  static String? postedDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.postedDate''',
      ));
}

class GetProductImagesCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    int? productId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Product Images',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products/${productId}/images',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? imagesReturned(dynamic response) => (getJsonField(
        response,
        r'''$.images''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class SendAMessageCall {
  static Future<ApiCallResponse> call({
    String? recipientName = '',
    String? senderName = '',
    String? messageContent = '',
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Send A Message',
      apiUrl: 'https://shopstateu-89a3d63aed8a.herokuapp.com/api/messages',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        'recipientName': recipientName,
        'senderName': senderName,
        'messageContent': messageContent,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetInboxMessagesCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? recepientName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Inbox Messages',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/messages/inbox?recipientName=${recepientName}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? senderName(dynamic response) => (getJsonField(
        response,
        r'''$[:].senderName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? senderProfilePicture(dynamic response) => (getJsonField(
        response,
        r'''$[:].senderProfilePicture''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? messageId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? messageContent(dynamic response) => (getJsonField(
        response,
        r'''$[:].messageContent''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? timeStamp(dynamic response) => (getJsonField(
        response,
        r'''$[:].timestamp''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UpdateProfilePictureCall {
  static Future<ApiCallResponse> call({
    int? userId,
    FFUploadedFile? profilePicture,
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Update Profile Picture',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/users/profile-picture',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        'userId': userId,
        'profilePicture': profilePicture,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic profilePictureUpdated(dynamic response) => getJsonField(
        response,
        r'''$.profilePicture''',
      );
}

class GetSentMessagesCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? senderName = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Sent Messages',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/messages/sent?senderName=${senderName}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? recipientProfilePicture(dynamic response) =>
      (getJsonField(
        response,
        r'''$[:].recipientProfilePicture''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? recipientName(dynamic response) => (getJsonField(
        response,
        r'''$[:].recipientName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? messageId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? messageContent(dynamic response) => (getJsonField(
        response,
        r'''$[:].messageContent''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? timeStamp(dynamic response) => (getJsonField(
        response,
        r'''$[:].timestamp''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class SaveAnItemCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    int? productId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Save an Item',
      apiUrl: 'https://shopstateu-89a3d63aed8a.herokuapp.com/api/saved-items',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        'productId': productId,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSavedItemsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Saved Items',
      apiUrl: 'https://shopstateu-89a3d63aed8a.herokuapp.com/api/saved-items',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? savedProductId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? savedProductName(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? savedDescription(dynamic response) => (getJsonField(
        response,
        r'''$[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? savedCategory(dynamic response) => (getJsonField(
        response,
        r'''$[:].category''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<double>? savedPrice(dynamic response) => (getJsonField(
        response,
        r'''$[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<String>? savedImagePath(dynamic response) => (getJsonField(
        response,
        r'''$[:].imagePath''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? savedSellerName(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? savedSellerCollege(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerCollege''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? savedSellerID(dynamic response) => (getJsonField(
        response,
        r'''$[:].userId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? savedPostedDate(dynamic response) => (getJsonField(
        response,
        r'''$[:].postedDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UnsaveAnItemCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    int? productId,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Unsave an Item',
      apiUrl: 'https://shopstateu-89a3d63aed8a.herokuapp.com/api/saved-items',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        'productId': productId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetMyListingsCall {
  static Future<ApiCallResponse> call({
    int? userId,
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get My Listings',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products/my-listings?userId=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<int>? productId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? productName(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? productDescription(dynamic response) => (getJsonField(
        response,
        r'''$[:].description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? productCategory(dynamic response) => (getJsonField(
        response,
        r'''$[:].category''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<double>? productPrice(dynamic response) => (getJsonField(
        response,
        r'''$[:].price''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<String>? sellerName(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerName''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? sellerCollege(dynamic response) => (getJsonField(
        response,
        r'''$[:].sellerCollege''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? userId(dynamic response) => (getJsonField(
        response,
        r'''$[:].userId''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? postedDate(dynamic response) => (getJsonField(
        response,
        r'''$[:].postedDate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? imagePath(dynamic response) => (getJsonField(
        response,
        r'''$[:].imagePath''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class DeleteAnItemCall {
  static Future<ApiCallResponse> call({
    int? productId,
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete an Item',
      apiUrl:
          'https://shopstateu-89a3d63aed8a.herokuapp.com/api/products?id=${productId}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
