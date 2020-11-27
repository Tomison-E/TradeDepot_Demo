import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tradedepot_demo/core/networkResponse/api_result.dart';

final fireStoreProvider = Provider((ref) => FirebaseFirestore.instance);
final fireBaseClientProvider= Provider((ref) => FireBaseClient(ref.read));

class FireBaseClient{

  FireBaseClient(this._read);
  final Reader _read;

  Future<ApiResult<bool>> post(String collection, Object data) async {
    CollectionReference _CR = _read(fireStoreProvider).collection(collection);
    try {
     final value = await _CR.add(data);
     return ApiResult.success(data: value != null ? true : false);
    }
    catch(e){
      print(e);
      return ApiResult.error(errorMsg: "Unable to process information");
    }

  }

  Future<ApiResult<bool>> Update(String collection, Object data, String docID) async {
    CollectionReference _CR = _read(fireStoreProvider).collection(collection);
    try {
       await _CR.doc(docID)
          .update(data);
      return ApiResult.success(data: true);
    }
    catch(e){
      print(e);
      return ApiResult.error(errorMsg: "Unable to process information");
    }

  }

  Future<QuerySnapshot> getWhere(String collection,String field, String value) async {
   // final data = await _read(fireStoreProvider).collection(collection).get();
    try {
      return _read(fireStoreProvider).collection(collection).where(field,isEqualTo: value).limit(1).get();
    }
    catch(e){
      print(e);
      return e;
    }

  }

}