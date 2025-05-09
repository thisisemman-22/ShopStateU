import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'product_details_widget.dart' show ProductDetailsWidget;
import 'package:flutter/material.dart';

class ProductDetailsModel extends FlutterFlowModel<ProductDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - API (Get User Profile)] action in Button widget.
  ApiCallResponse? getUserProfileAPI;
  // Stores action output result for [Backend Call - API (Save an Item)] action in IconButton widget.
  ApiCallResponse? saveItemAPI;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
