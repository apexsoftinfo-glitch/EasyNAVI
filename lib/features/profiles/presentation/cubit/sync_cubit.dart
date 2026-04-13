import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../addresses/domain/repositories/addresses_repository.dart';
import '../../../addresses/data/models/address_model.dart';
import 'sync_state.dart';

@injectable
class SyncCubit extends Cubit<SyncState> {
  final AddressesRepository _addressesRepository;

  SyncCubit(this._addressesRepository) : super(const SyncState.initial());

  Future<void> exportBackup() async {
    emit(const SyncState.loading());
    try {
      final addresses = await _addressesRepository.getAddresses();
      final backupData = {
        'version': 1,
        'exported_at': DateTime.now().toIso8601String(),
        'addresses': addresses.map((e) => e.toJson()).toList(),
      };

      final jsonString = jsonEncode(backupData);
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/easynavi_backup_${DateTime.now().millisecondsSinceEpoch}.json');
      
      await file.writeAsString(jsonString);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          subject: 'EasyNAVI Backup',
        ),
      );

      emit(const SyncState.initial());
    } catch (e) {
      emit(const SyncState.error('export-failed'));
    }
  }

  Future<void> importBackup() async {
    emit(const SyncState.loading());
    try {
      final FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.single.path == null) {
        emit(const SyncState.initial());
        return;
      }

      final file = File(result.files.single.path!);
      final jsonString = await file.readAsString();
      final Map<String, dynamic> data = jsonDecode(jsonString);

      if (!data.containsKey('addresses')) {
        emit(const SyncState.error('invalid-backup-file'));
        return;
      }

      final List<dynamic> addressesJson = data['addresses'];
      int importedCount = 0;

      for (final json in addressesJson) {
        try {
          final address = AddressModel.fromJson(json as Map<String, dynamic>);
          // Clean up ID so it creates new ones in DB
          final newAddress = address.copyWith(id: ''); 
          await _addressesRepository.addAddress(newAddress);
          importedCount++;
        } catch (e) {
          // Skip invalid entries
        }
      }

      emit(SyncState.success('Zaimportowano $importedCount adresów'));
    } catch (e) {
      emit(const SyncState.error('import-failed'));
    }
  }

  void reset() {
    emit(const SyncState.initial());
  }
}
