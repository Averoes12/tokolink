import 'package:tokolink/model/shipping.dart';
import 'package:tokolink/model/tracking.dart';
import 'package:tokolink/model/transaction.dart';

abstract class TransactionRepository {
  Future<void> createTransaction(Transaction transaction);

  Future<List> getTransactions();

  Future<Tracking> getTracking(String id);

  Future<Shipping> getShipping(String lat, String lng);

  Future<void> review(Transaction transaction);
}
