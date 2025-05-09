import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_listings_model.dart';
export 'my_listings_model.dart';

class MyListingsWidget extends StatefulWidget {
  const MyListingsWidget({super.key});

  static String routeName = 'myListings';
  static String routePath = '/myListings';

  @override
  State<MyListingsWidget> createState() => _MyListingsWidgetState();
}

class _MyListingsWidgetState extends State<MyListingsWidget> {
  late MyListingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyListingsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.myListings = await GetMyListingsCall.call(
        userId: FFAppState().PersistUserId,
        bearerToken: FFAppState().bearerToken,
      );

      if ((_model.myListings?.succeeded ?? true)) {
        return;
      }

      await showDialog(
        context: context,
        builder: (alertDialogContext) {
          return AlertDialog(
            title: Text('Error'),
            content: Text((_model.myListings?.bodyText ?? '')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(alertDialogContext),
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
      return;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'My Listings',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.poppins(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).info,
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 0.0),
              child: Builder(
                builder: (context) {
                  final productIdChild = GetMyListingsCall.productId(
                        (_model.myListings?.jsonBody ?? ''),
                      )?.toList() ??
                      [];

                  return RefreshIndicator(
                    color: FlutterFlowTheme.of(context).primary,
                    onRefresh: () async {
                      safeSetState(() {});
                    },
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: () {
                          if (MediaQuery.sizeOf(context).width <
                              kBreakpointSmall) {
                            return 2;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointMedium) {
                            return 3;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointLarge) {
                            return 4;
                          } else {
                            return 5;
                          }
                        }(),
                        crossAxisSpacing: 6.0,
                        mainAxisSpacing: 6.0,
                        childAspectRatio: 0.69,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: productIdChild.length,
                      itemBuilder: (context, productIdChildIndex) {
                        final productIdChildItem =
                            productIdChild[productIdChildIndex];
                        return Container(
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x1A000000),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                var _shouldSetState = false;
                                FFAppState().productIdCurrent =
                                    productIdChildItem;
                                safeSetState(() {});
                                _model.getProductDetailsNoImage =
                                    await GetProductDetailsNoImageCall.call(
                                  productId: FFAppState().productIdCurrent,
                                  bearerToken: FFAppState().bearerToken,
                                );

                                _shouldSetState = true;
                                if ((_model
                                        .getProductDetailsNoImage?.succeeded ??
                                    true)) {
                                  _model.getProductImages =
                                      await GetProductImagesCall.call(
                                    bearerToken: FFAppState().bearerToken,
                                    productId: FFAppState().productIdCurrent,
                                  );

                                  _shouldSetState = true;
                                  if ((_model.getProductImages?.succeeded ??
                                      true)) {
                                    FFAppState().openedID =
                                        GetProductDetailsNoImageCall.productId(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openedName =
                                        GetProductDetailsNoImageCall
                                            .productName(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openedDescription =
                                        GetProductDetailsNoImageCall
                                            .productDescription(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openedCategory =
                                        GetProductDetailsNoImageCall
                                            .productCategory(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openedPrice =
                                        GetProductDetailsNoImageCall
                                            .productPrice(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openedSellerName =
                                        GetProductDetailsNoImageCall.sellerName(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openedSellerCollege =
                                        GetProductDetailsNoImageCall
                                            .sellerCollege(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openeduserIdSeller =
                                        GetProductDetailsNoImageCall.userId(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openedPostedDate =
                                        GetProductDetailsNoImageCall.postedDate(
                                      (_model.getProductDetailsNoImage
                                              ?.jsonBody ??
                                          ''),
                                    )!;
                                    FFAppState().openedImagesPath =
                                        GetProductImagesCall.imagesReturned(
                                      (_model.getProductImages?.jsonBody ?? ''),
                                    )!
                                            .toList()
                                            .cast<String>();
                                    safeSetState(() {});
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text((_model
                                                  .getProductImages?.bodyText ??
                                              '')),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (_shouldSetState) safeSetState(() {});
                                    return;
                                  }
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        content: Text((_model
                                                .getProductDetailsNoImage
                                                ?.bodyText ??
                                            '')),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }

                                context
                                    .pushNamed(ProductDetailsWidget.routeName);

                                if (_shouldSetState) safeSetState(() {});
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed(
                                              ProductDetailsWidget.routeName);
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Image.network(
                                            (GetMyListingsCall.imagePath(
                                              (_model.myListings?.jsonBody ??
                                                  ''),
                                            )!
                                                .elementAtOrNull(
                                                    productIdChildIndex))!,
                                            width: double.infinity,
                                            height: 120.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 8.0, 8.0, 0.0),
                                          child: Container(
                                            width: 70.0,
                                            height: 24.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Text(
                                                'P${(GetMyListingsCall.productPrice(
                                                  (_model.myListings
                                                          ?.jsonBody ??
                                                      ''),
                                                )?.elementAtOrNull(productIdChildIndex))?.toString()}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodySmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .info,
                                                      fontSize: 10.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 5.0),
                                          child: AutoSizeText(
                                            valueOrDefault<String>(
                                              GetMyListingsCall.productName(
                                                (_model.myListings?.jsonBody ??
                                                    ''),
                                              )?.elementAtOrNull(
                                                  productIdChildIndex),
                                              '[ERROR productName]',
                                            ),
                                            maxLines: 1,
                                            minFontSize: 12.0,
                                            style: FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.school_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 16.0,
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                GetMyListingsCall.sellerCollege(
                                                  (_model.myListings
                                                          ?.jsonBody ??
                                                      ''),
                                                )?.elementAtOrNull(
                                                    productIdChildIndex),
                                                '[ERROR college]',
                                              ),
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 4.0)),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.category_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 16.0,
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                GetMyListingsCall
                                                    .productCategory(
                                                  (_model.myListings
                                                          ?.jsonBody ??
                                                      ''),
                                                )?.elementAtOrNull(
                                                    productIdChildIndex),
                                                '[ERROR category]',
                                              ),
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 4.0)),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.access_time_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 16.0,
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                GetMyListingsCall.postedDate(
                                                  (_model.myListings
                                                          ?.jsonBody ??
                                                      ''),
                                                )?.elementAtOrNull(
                                                    productIdChildIndex),
                                                '[ERROR dateTime]',
                                              ),
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    fontSize: 10.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 4.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                var confirmDialogResponse =
                                                    await showDialog<bool>(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Mark as Sold'),
                                                              content: Text(
                                                                  'Are you sure you want to mark ${GetMyListingsCall.productName(
                                                                (_model.myListings
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )?.elementAtOrNull(productIdChildIndex)} as sold?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                  child: Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext,
                                                                          true),
                                                                  child: Text(
                                                                      'Confirm'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ) ??
                                                        false;
                                                if (confirmDialogResponse) {
                                                  await showDialog(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            'Product Deleted'),
                                                        content: Text(
                                                            'Product successfully deleted.'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );

                                                  safeSetState(() {});
                                                  return;
                                                } else {
                                                  return;
                                                }
                                              },
                                              text: 'Mark as Sold',
                                              options: FFButtonOptions(
                                                height: 20.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 10.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  FFAppState().editName =
                                                      (GetMyListingsCall
                                                              .productName(
                                                    (_model.myListings
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                          .elementAtOrNull(
                                                              productIdChildIndex))!;
                                                  FFAppState().editDescription =
                                                      (GetMyListingsCall
                                                              .productDescription(
                                                    (_model.myListings
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                          .elementAtOrNull(
                                                              productIdChildIndex))!;
                                                  FFAppState().editCategory =
                                                      (GetMyListingsCall
                                                              .productCategory(
                                                    (_model.myListings
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                          .elementAtOrNull(
                                                              productIdChildIndex))!;
                                                  FFAppState().editPrice =
                                                      (GetMyListingsCall
                                                              .productPrice(
                                                    (_model.myListings
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!
                                                          .elementAtOrNull(
                                                              productIdChildIndex))!;
                                                  FFAppState().editProdId =
                                                      productIdChildItem;
                                                  safeSetState(() {});

                                                  context.pushNamed(
                                                      EditProductWidget
                                                          .routeName);
                                                },
                                                child: FaIcon(
                                                  FontAwesomeIcons.pen,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 16.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ].divide(SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}
