import 'package:injectable/injectable.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract class DeviceService {
  Future<void> enableWakelock();
  Future<void> disableWakelock();
}

@LazySingleton(as: DeviceService)
class DeviceServiceImpl implements DeviceService {
  @override
  Future<void> enableWakelock() => WakelockPlus.enable();

  @override
  Future<void> disableWakelock() => WakelockPlus.disable();
}
