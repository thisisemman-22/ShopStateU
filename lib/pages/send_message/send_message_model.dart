import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'send_message_widget.dart' show SendMessageWidget;
import 'package:flutter/material.dart';

class SendMessageModel extends FlutterFlowModel<SendMessageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for message widget.
  FocusNode? messageFocusNode;
  TextEditingController? messageTextController;
  String? Function(BuildContext, String?)? messageTextControllerValidator;
  // Stores action output result for [Backend Call - API (Send A Message)] action in Button widget.
  ApiCallResponse? sendMessage;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    messageFocusNode?.dispose();
    messageTextController?.dispose();
  }
}
