import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/address_model.dart';
import '../../../../core/exceptions/app_exception.dart';
import 'package:injectable/injectable.dart';

abstract class AddressesDataSource {
  Future<List<AddressModel>> getAddresses();
  Future<AddressModel> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> deleteAddress(String id);
  Stream<List<Map<String, dynamic>>> getAddressesStream();
}

@LazySingleton(as: AddressesDataSource)
class AddressesDataSourceImpl implements AddressesDataSource {
  final SupabaseClient _supabase;

  AddressesDataSourceImpl(this._supabase);

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      final response = await _supabase
          .from('easynavi_addresses')
          .select()
          .order('name', ascending: true);
      return (response as List).map((json) => AddressModel.fromJson(json)).toList();
    } catch (e) {
      throw const AppException('failed-to-fetch-addresses');
    }
  }

  @override
  Future<AddressModel> addAddress(AddressModel address) async {
    try {
      final json = address.toJson()..remove('id')..remove('created_at');
      final response = await _supabase
          .from('easynavi_addresses')
          .insert(json)
          .select()
          .single();
      return AddressModel.fromJson(response);
    } catch (e) {
      throw const AppException('failed-to-add-address');
    }
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    try {
      final json = address.toJson()..remove('id')..remove('created_at')..remove('user_id');
      await _supabase
          .from('easynavi_addresses')
          .update(json)
          .eq('id', address.id);
    } catch (e) {
      throw const AppException('failed-to-update-address');
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      await _supabase
          .from('easynavi_addresses')
          .delete()
          .eq('id', id);
    } catch (e) {
      throw const AppException('failed-to-delete-address');
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getAddressesStream() {
    return _supabase
        .from('easynavi_addresses')
        .stream(primaryKey: ['id'])
        .order('name', ascending: true);
  }
}
