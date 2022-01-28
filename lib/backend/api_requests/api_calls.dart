import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class QRcodeCall {
  static Future<ApiCallResponse> call({
    String data = '',
    String size = '250x250',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'QRcode',
      apiUrl: 'http://api.qrserver.com/v1/create-qr-code/',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'data': data,
        'size': size,
      },
      returnBody: true,
    );
  }
}
