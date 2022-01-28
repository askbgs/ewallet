import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'account_record.g.dart';

abstract class AccountRecord
    implements Built<AccountRecord, AccountRecordBuilder> {
  static Serializer<AccountRecord> get serializer => _$accountRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'account_id')
  String get accountId;

  @nullable
  @BuiltValueField(wireName: 'account_name')
  String get accountName;

  @nullable
  double get amount;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(AccountRecordBuilder builder) => builder
    ..accountId = ''
    ..accountName = ''
    ..amount = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('account');

  static Stream<AccountRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<AccountRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  AccountRecord._();
  factory AccountRecord([void Function(AccountRecordBuilder) updates]) =
      _$AccountRecord;

  static AccountRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createAccountRecordData({
  String accountId,
  String accountName,
  double amount,
  DocumentReference userId,
}) =>
    serializers.toFirestore(
        AccountRecord.serializer,
        AccountRecord((a) => a
          ..accountId = accountId
          ..accountName = accountName
          ..amount = amount
          ..userId = userId));
