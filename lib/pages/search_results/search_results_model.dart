import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'search_results_widget.dart' show SearchResultsWidget;
import 'package:flutter/material.dart';

class SearchResultsModel extends FlutterFlowModel<SearchResultsWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Search Products)] action in searchResults widget.
  ApiCallResponse? searchProductsAPI;
  // State field(s) for textFieldResults widget.
  FocusNode? textFieldResultsFocusNode;
  TextEditingController? textFieldResultsTextController;
  String? Function(BuildContext, String?)?
      textFieldResultsTextControllerValidator;
  // Stores action output result for [Backend Call - API (Get Product Details No Image)] action in Column widget.
  ApiCallResponse? getProductDetailsNoImage;
  // Stores action output result for [Backend Call - API (Get Product Images)] action in Column widget.
  ApiCallResponse? getProductImages;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldResultsFocusNode?.dispose();
    textFieldResultsTextController?.dispose();
  }
}
