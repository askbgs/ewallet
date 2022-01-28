import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

String getaccount(String inputvar) {
  // Add your function code here!
  return inputvar.split(';')[1];
}

String getuserid(String inputvar) {
  // Add your function code here!
  return inputvar.split(';')[0];
}

String getFirstchar(String name) {
  // Add your function code here!
  return "${name[0]}";
}

String getName(String userid) {
  final firebaseInstance = FirebaseFirestore.instance;
  return "OK";
}

DocumentReference getUserID(String userid) {
  // Add your function code here!
  return FirebaseFirestore.instance.doc('users/$userid');
}

DocumentReference getCurrentBalance(String accountid) {
  // Add your function code here!
  return FirebaseFirestore.instance.doc('account/$accountid');
}
