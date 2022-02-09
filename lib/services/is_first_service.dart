import 'package:get_storage/get_storage.dart';

class IsFirstService {
  final _getStorage = GetStorage();
  final storageKey = 'isFirst';
  bool getIsFirst() {
    return isSavedIsFirst();
  }

  bool isSavedIsFirst() {
    return _getStorage.read(storageKey) ?? true;
  }

  void saveIsFirst(bool isIsFirst) {
    _getStorage.write(storageKey, isIsFirst);
  }
}
