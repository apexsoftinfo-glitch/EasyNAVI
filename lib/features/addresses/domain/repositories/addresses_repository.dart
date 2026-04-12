import '../../data/datasources/addresses_data_source.dart';
import '../../data/models/address_model.dart';
import 'package:injectable/injectable.dart';

abstract class AddressesRepository {
  Future<List<AddressModel>> getAddresses();
  Future<AddressModel> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> deleteAddress(String id);
  Stream<List<AddressModel>> observeAddresses();
}

@LazySingleton(as: AddressesRepository)
class AddressesRepositoryImpl implements AddressesRepository {
  final AddressesDataSource _dataSource;

  AddressesRepositoryImpl(this._dataSource);

  @override
  Future<List<AddressModel>> getAddresses() => _dataSource.getAddresses();

  @override
  Future<AddressModel> addAddress(AddressModel address) => _dataSource.addAddress(address);

  @override
  Future<void> updateAddress(AddressModel address) => _dataSource.updateAddress(address);

  @override
  Future<void> deleteAddress(String id) => _dataSource.deleteAddress(id);

  @override
  Stream<List<AddressModel>> observeAddresses() {
    return _dataSource.getAddressesStream().map(
          (list) => list.map((json) => AddressModel.fromJson(json)).toList(),
        );
  }
}
