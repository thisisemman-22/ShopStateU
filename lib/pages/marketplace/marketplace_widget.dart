import '/backend/api_requests/api_calls.dart';
import '/components/no_products_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'marketplace_model.dart';
export 'marketplace_model.dart';

class MarketplaceWidget extends StatefulWidget {
  const MarketplaceWidget({super.key});

  static String routeName = 'marketplace';
  static String routePath = '/marketplace';

  @override
  State<MarketplaceWidget> createState() => _MarketplaceWidgetState();
}

class _MarketplaceWidgetState extends State<MarketplaceWidget> {
  late MarketplaceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarketplaceModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (RootPageContext.isInactiveRootPage(context)) {
        return;
      }
      _model.allProductts = await GetAllProductsCall.call(
        bearerToken: FFAppState().bearerToken,
      );

      if ((_model.allProductts?.succeeded ?? true)) {
        safeSetState(() {});
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Error'),
              content: Text((_model.allProductts?.bodyText ?? '')),
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
      }
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Browse Listings',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.poppins(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
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
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 80.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      final productIDChild = GetAllProductsCall.productId(
                            (_model.allProductts?.jsonBody ?? ''),
                          )?.toList() ??
                          [];
                      if (productIDChild.isEmpty) {
                        return Center(
                          child: NoProductsWidget(),
                        );
                      }

                      return RefreshIndicator(
                        color: FlutterFlowTheme.of(context).primary,
                        onRefresh: () async {
                          safeSetState(() {});
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                          itemCount: productIDChild.length,
                          itemBuilder: (context, productIDChildIndex) {
                            final productIDChildItem =
                                productIDChild[productIDChildIndex];
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
                                        productIDChildItem;
                                    safeSetState(() {});
                                    _model.getProductDetailsNoImage =
                                        await GetProductDetailsNoImageCall.call(
                                      productId: FFAppState().productIdCurrent,
                                      bearerToken: FFAppState().bearerToken,
                                    );

                                    _shouldSetState = true;
                                    if ((_model.getProductDetailsNoImage
                                            ?.succeeded ??
                                        true)) {
                                      _model.getProductImages =
                                          await GetProductImagesCall.call(
                                        bearerToken: FFAppState().bearerToken,
                                        productId:
                                            FFAppState().productIdCurrent,
                                      );

                                      _shouldSetState = true;
                                      if ((_model.getProductImages?.succeeded ??
                                          true)) {
                                        FFAppState().openedID =
                                            GetProductDetailsNoImageCall
                                                .productId(
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
                                            GetProductDetailsNoImageCall
                                                .sellerName(
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
                                            GetProductDetailsNoImageCall
                                                .postedDate(
                                          (_model.getProductDetailsNoImage
                                                  ?.jsonBody ??
                                              ''),
                                        )!;
                                        FFAppState().openedImagesPath =
                                            GetProductImagesCall.imagesReturned(
                                          (_model.getProductImages?.jsonBody ??
                                              ''),
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
                                                      .getProductImages
                                                      ?.bodyText ??
                                                  '')),
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
                                        if (_shouldSetState)
                                          safeSetState(() {});
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

                                    context.pushNamed(
                                        ProductDetailsWidget.routeName);

                                    if (_shouldSetState) safeSetState(() {});
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: Image.network(
                                              (GetAllProductsCall.imagePath(
                                                (_model.allProductts
                                                        ?.jsonBody ??
                                                    ''),
                                              )!
                                                  .elementAtOrNull(
                                                      productIDChildIndex))!,
                                              width: double.infinity,
                                              height: 120.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(1.0, -1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 8.0, 8.0, 0.0),
                                              child: Container(
                                                width: 70.0,
                                                height: 24.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Text(
                                                    'P${(GetAllProductsCall.price(
                                                      (_model.allProductts
                                                              ?.jsonBody ??
                                                          ''),
                                                    )?.elementAtOrNull(productIDChildIndex))?.toString()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 5.0),
                                              child: AutoSizeText(
                                                valueOrDefault<String>(
                                                  GetAllProductsCall
                                                      .productName(
                                                    (_model.allProductts
                                                            ?.jsonBody ??
                                                        ''),
                                                  )?.elementAtOrNull(
                                                      productIDChildIndex),
                                                  '[ERROR]',
                                                ),
                                                maxLines: 1,
                                                minFontSize: 12.0,
                                                style: FlutterFlowTheme.of(
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
                                                  Icons.person,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16.0,
                                                ),
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    GetAllProductsCall
                                                        .sellerName(
                                                      (_model.allProductts
                                                              ?.jsonBody ??
                                                          ''),
                                                    )?.elementAtOrNull(
                                                        productIDChildIndex),
                                                    '[Seller Name]',
                                                  ),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
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
                                                  Icons.school_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16.0,
                                                ),
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    GetAllProductsCall
                                                        .sellerCollege(
                                                      (_model.allProductts
                                                              ?.jsonBody ??
                                                          ''),
                                                    )?.elementAtOrNull(
                                                        productIDChildIndex),
                                                    '[Seller College]',
                                                  ),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16.0,
                                                ),
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    GetAllProductsCall.category(
                                                      (_model.allProductts
                                                              ?.jsonBody ??
                                                          ''),
                                                    )?.elementAtOrNull(
                                                        productIDChildIndex),
                                                    '[Category]',
                                                  ),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 16.0,
                                                ),
                                                AutoSizeText(
                                                  valueOrDefault<String>(
                                                    GetAllProductsCall
                                                        .postedDate(
                                                      (_model.allProductts
                                                              ?.jsonBody ??
                                                          ''),
                                                    )?.elementAtOrNull(
                                                        productIDChildIndex),
                                                    '[Posted Date]',
                                                  ),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
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
        ),
      ),
    );
  }
}
