import 'dart:convert';

import 'package:login_cubit/core/i_cache_manager.dart';
import 'package:login_cubit/core/model/base_model.dart';

class CacheManager extends ICacheManager {
  @override
  Future<bool> addToCache<T>(String id, T model) async {
    final _stringModel = jsonEncode(model);
    return await sprefs.setString(key<T>(id), _stringModel);
  }

  @override
  List<T> getCacheList<T extends BaseModel>(BaseModel model) {
    final cacheList =
        sprefs.getKeys().where((element) => element.contains('$T')).toList();
    if (cacheList.isEmpty) return [];

    return cacheList
        .map((e) => model.fromJson(jsonDecode(sprefs.getString(e) ?? '')) as T)
        .toList();
  }

  @override
  Future<T> getFromCache<T extends BaseModel>(String id, BaseModel model) {
    final cacheData = sprefs.getString(key<T>(id)) ?? '';
    final modelJson = jsonDecode(cacheData);
    return model.fromJson(modelJson);
  }

  @override
  Future<bool> removeAllFromCache<T>() async{
    final cacheList = sprefs.getKeys().where((element) => element.contains('$T')).toList();
    for(var i = 0; i < cacheList.length; i++){
      await sprefs.remove(cacheList[i]);
    }
    return true;
  }

  @override
  Future<bool> removeFromCache<T>(String id) async {
    return await sprefs.remove('${T.runtimeType}$id');
  }
}
