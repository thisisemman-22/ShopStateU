import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_listings_widget.dart' show MyListingsWidget;
import 'package:flutter/material.dart';

class MyListingsModel extends FlutterFlowModel<MyListingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Get My Listings)] action in myListings widget.
  ApiCallResponse? myListings;
  // Stores action output result for [Backend Call - API (Get Product Details No Image)] action in Column widget.
  ApiCallResponse? getProductDetailsNoImage;
  // Stores action output result for [Backend Call - API (Get Product Images)] action in Column widget.
  ApiCallResponse? getProductImages;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
