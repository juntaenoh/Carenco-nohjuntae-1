import 'dart:convert';

import 'package:fisica/views/TestMode/Tester_Scandata.dart';
import 'package:fisica/views/home/scan/scandata.dart';
import 'package:fisica/utils/service/Foot_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fisica/index.dart';
import 'package:provider/provider.dart';

class FootResult extends StatefulWidget {
  final String mode;
  const FootResult({Key? key, required this.mode}) : super(key: key);

  @override
  State<FootResult> createState() => _FootResultState();
}

class _FootResultState extends State<FootResult> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var data;
  bool main = true;
  @override
  void initState() {
    super.initState();
    if (widget.mode != 'main') {
      main = false;
    }

    // addPostFrameCallback을 사용하여 initState 이후에 모달을 표시하도록 함
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheetWithStates(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> showModalBottomSheetWithStates(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) => main ? ScanData(mode: widget.mode, footdata: AppStateNotifier.instance.footdata!.first) : Scantest(mode: widget.mode),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }
    return Consumer<AppStateNotifier>(builder: (context, AppStateNotifier, child) {
      data = AppStateNotifier.scandata;
      return GestureDetector(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColors.Black,
            appBar: AppBar(
              backgroundColor: Color(0x00CCFF8B),
              automaticallyImplyLeading: false,
              title: Text(
                SetLocalizations.of(context).getText(
                  'reportPlantarPressureLabel' /* Page Title */,
                ),
                style: AppFont.s18.overrides(color: AppColors.primaryBackground),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 24,
                    color: AppColors.primaryBackground,
                  ),
                  onPressed: () {
                    main ? context.pushNamed('LandingScreen') : context.pushNamed('Tester_menu');
                  },
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (data['imageUrl'] != null)
                  Container(
                    width: double.infinity,
                    height: 327,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: Image.network(
                      data['imageUrl'],
                      width: 327,
                      fit: BoxFit.contain,
                    ),
                  ),
                Container(
                  width: 252,
                  height: 52.0,
                  decoration: BoxDecoration(),
                  child: LodingButtonWidget(
                    onPressed: () async {
                      main ? context.pushNamed('FootDetail', extra: data['imageUrl']) : context.pushNamed('testFootDetail', extra: data['imageUrl']);
                    },
                    text: SetLocalizations.of(context).getText(
                      'reportPlantarPressureButtonCompareLabel' /*이상적인 Page Title */,
                    ),
                    options: LodingButtonOptions(
                      height: 40.0,
                      padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: AppColors.primary,
                      textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 56.0,
                        decoration: BoxDecoration(),
                        child: LodingButtonWidget(
                          onPressed: () {
                            showModalBottomSheetWithStates(context);
                          },
                          text: SetLocalizations.of(context).getText(
                            'reportPlantarPressureDetailbutton' /*리포트 상세 내용 보기 */,
                          ),
                          options: LodingButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: AppColors.primaryBackground,
                            textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.Black),
                            elevation: 0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        height: 56.0,
                        decoration: BoxDecoration(),
                        child: LodingButtonWidget(
                          onPressed: () {
                            main ? context.goNamed('Footprint', extra: 'main') : context.goNamed('Teseter_Scan', extra: 2);
                          },
                          text: SetLocalizations.of(context).getText(
                            'reportPlantarPressureButtonRetryLabel' /* 다시 측정하기 */,
                          ),
                          options: LodingButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: AppColors.Black,
                            textStyle: AppFont.s18.overrides(fontSize: 16, color: AppColors.primaryBackground),
                            elevation: 0,
                            borderSide: BorderSide(
                              color: AppColors.primaryBackground,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      );
    });
  }
}
