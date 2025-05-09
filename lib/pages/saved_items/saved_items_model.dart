import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'saved_items_widget.dart' show SavedItemsWidget;
import 'package:flutter/material.dart';

class SavedItemsModel extends FlutterFlowModel<SavedItemsWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Get Saved Items)] action in savedItems widget.
  ApiCallResponse? getSavedItemsAPI;
  // Stores action output result for [Backend Call - API (Get Product Details No Image)] action in Column widget.
  ApiCallResponse? getProductDetailsNoImage;
  // Stores action output result for [Backend Call - API (Get Product Images)] action in Column widget.
  ApiCallResponse? getProductImages;
  // Stores action output result for [Backend Call - API (Unsave an Item)] action in Icon widget.
  ApiCallResponse? unsaveItemAPI;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
