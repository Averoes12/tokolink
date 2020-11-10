import 'package:tokolink/model/address.dart';

abstract class AddressRepository {
  Future<List<Address>> getAddresses();

  Future<Address> getAddress(String id);

  Future<void> createAddress(Address address);
}
