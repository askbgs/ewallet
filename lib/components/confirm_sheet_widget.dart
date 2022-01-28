import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmSheetWidget extends StatefulWidget {
  const ConfirmSheetWidget({
    Key key,
    this.sname,
    this.semail,
    this.samount,
    this.snote,
    this.senderaccount,
    this.reciveraccount,
  }) : super(key: key);

  final String sname;
  final String semail;
  final int samount;
  final String snote;
  final String senderaccount;
  final String reciveraccount;

  @override
  _ConfirmSheetWidgetState createState() => _ConfirmSheetWidgetState();
}

class _ConfirmSheetWidgetState extends State<ConfirmSheetWidget> {
  TransactionsRecord tranId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              color: Color(0x32171717),
              offset: Offset(0, -4),
            )
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Color(0xFFDBE2E7),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Send Money',
                      style: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Icon(
                        Icons.person_outline_sharp,
                        color: Color(0xFF00C9A9),
                        size: 24,
                      ),
                    ),
                    Text(
                      widget.sname,
                      style: FlutterFlowTheme.bodyText2.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Icon(
                        Icons.email_outlined,
                        color: Color(0xFF00C9A9),
                        size: 24,
                      ),
                    ),
                    Text(
                      widget.semail,
                      style: FlutterFlowTheme.bodyText2.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Icon(
                        Icons.money,
                        color: Color(0xFF00C9A9),
                        size: 24,
                      ),
                    ),
                    Text(
                      formatNumber(
                        widget.samount,
                        formatType: FormatType.decimal,
                        decimalType: DecimalType.automatic,
                      ),
                      style: FlutterFlowTheme.bodyText2.override(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF090F13),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: Icon(
                        Icons.note_outlined,
                        color: Color(0xFF00C9A9),
                        size: 24,
                      ),
                    ),
                    Text(
                      widget.snote,
                      style: FlutterFlowTheme.bodyText1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0, -0.05),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final transactionsCreateData =
                            createTransactionsRecordData(
                          tranId:
                              'tran-${functions.genUniqueid(currentUserUid)}',
                          recieverAccount:
                              functions.getaccount(widget.reciveraccount),
                          senderUserid: currentUserReference,
                          recieverUserid: functions.getUserID(
                              functions.getuserid(widget.reciveraccount)),
                          amount: widget.samount,
                          tranDate: getCurrentTimestamp,
                          senderAccount: widget.senderaccount,
                        );
                        final transactionsRecordReference =
                            TransactionsRecord.collection.doc();
                        await transactionsRecordReference
                            .set(transactionsCreateData);
                        tranId = TransactionsRecord.getDocumentFromData(
                            transactionsCreateData,
                            transactionsRecordReference);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageWidget(),
                          ),
                        );

                        setState(() {});
                      },
                      text: 'Confirm Send',
                      options: FFButtonOptions(
                        width: 350,
                        height: 60,
                        color: Color(0xFF00C9A9),
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF141414),
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        elevation: 2,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
