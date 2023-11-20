import '/auth/firebase_auth/auth_util.dart';
import '../flutter_set/flutter_drop_down.dart';
import '../flutter_set/flutter_flow_util.dart';
import '../flutter_set/form_field_controller.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  FormFieldController<String>? dropDownValueController2;

  FocusNode? phoneFocusNode;
  TextEditingController? phoneController;
  String? Function(BuildContext, String?)? phoneControllerValidator;

  FocusNode? pwFocusNode;
  TextEditingController? pwController;
  late bool pwVisibility;
  String? Function(BuildContext, String?)? pwControllerValidator;
  FocusNode? pw2FocusNode;
  TextEditingController? pw2Controller;
  late bool pw2Visibility;
  String? Function(BuildContext, String?)? pw2ControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    pwVisibility = false;
    pw2Visibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    phoneFocusNode?.dispose();
    phoneController?.dispose();
    pwFocusNode?.dispose();
    pwController?.dispose();

    pw2FocusNode?.dispose();
    pw2Controller?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
