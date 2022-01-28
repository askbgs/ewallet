// Automatic FlutterFlow imports
import '../../backend/backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

// Begin custom action code
Future<bool> validate(
  double availablebalance,
  double sendingamount,
) async {
  // Add your function code here!
  if (sendingamount > availablebalance) {
    return false;
  } else {
    return true;
  }
}
