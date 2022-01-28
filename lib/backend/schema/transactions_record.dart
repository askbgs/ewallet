import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'transactions_record.g.dart';

abstract class TransactionsRecord
    implements Built<TransactionsRecord, TransactionsRecordBuilder> {
  static Serializer<TransactionsRecord> get serializer =>
      _$transactionsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'tran_id')
  String get tranId;

  @nullable
  @BuiltValueField(wireName: 'sender_account')
  String get senderAccount;

  @nullable
  @BuiltValueField(wireName: 'reciever_account')
  String get recieverAccount;

  @nullable
  int get amount;

  @nullable
  @BuiltValueField(wireName: 'tran_date')
  DateTime get tranDate;

  @nullable
  @BuiltValueField(wireName: 'sender_userid')
  DocumentReference get senderUserid;

  @nullable
  @BuiltValueField(wireName: 'reciever_userid')
  DocumentReference get recieverUserid;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TransactionsRecordBuilder builder) => builder
    ..tranId = ''
    ..senderAccount = ''
    ..recieverAccount = ''
    ..amount = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  TransactionsRecord._();
  factory TransactionsRecord(
          [void Function(TransactionsRecordBuilder) updates]) =
      _$TransactionsRecord;

  static TransactionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTransactionsRecordData({
  String tranId,
  String senderAccount,
  String recieverAccount,
  int amount,
  DateTime tranDate,
  DocumentReference senderUserid,
  DocumentReference recieverUserid,
}) =>
    serializers.toFirestore(
        TransactionsRecord.serializer,
        TransactionsRecord((t) => t
          ..tranId = tranId
          ..senderAccount = senderAccount
          ..recieverAccount = recieverAccount
          ..amount = amount
          ..tranDate = tranDate
          ..senderUserid = senderUserid
          ..recieverUserid = recieverUserid));
