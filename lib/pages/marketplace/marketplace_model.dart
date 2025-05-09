import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'marketplace_widget.dart' show MarketplaceWidget;
import 'package:flutter/material.dart';

class MarketplaceModel extends FlutterFlowModel<MarketplaceWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Get All Products)] action in marketplace widget.
  ApiCallResponse? allProductts;
  // Stores action output result for [Backend Call - API (Get Product Details No Image)] action in Column widget.
  ApiCallResponse? getProductDetailsNoImage;
  // Stores action output result for [Backend Call - API (Get Product Images)] action in Column widget.
  ApiCallResponse? getProductImages;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
