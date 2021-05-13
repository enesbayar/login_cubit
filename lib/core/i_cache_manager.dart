import 'package:login_cubit/core/model/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICacheManager {
  late SharedPreferences sprefs;
  Future<void> initPreferences() async =>
      sprefs = await SharedPreferences.getInstance();

  Future<bool> addToCache<T>(String id, T model);
  Future<bool> removeFromCache<T>(String id);
  Future<T> getFromCache<T extends BaseModel>(String id, BaseModel model);
  List<T> getCacheList<T extends BaseModel>(BaseModel model);
  Future<bool> removeAllFromCache<T>();
  String key<T>(String id) => '${T.toString()}$id';

}
