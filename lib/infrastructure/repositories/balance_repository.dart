import 'package:tokolink/model/balance.dart';
import 'package:tokolink/model/bank.dart';
import 'package:tokolink/model/virtual_account.dart';

abstract class BalanceRepository {
  Future<List<Balance>> getBalanceHistory();

  Future<List<Bank>> getBanks();

  Future<List<VirtualAccount>> getVirtualAccounts();

  Future<VirtualAccountDetail> getVirtualAccountDetail(String name);
}
