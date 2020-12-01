import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tradedepot_demo/core/networkResponse/api_result.dart';


class FireBaseClient{

  FireBaseClient(this._fireStore);
  final FirebaseFirestore _fireStore;

  Future<ApiResult<bool>> post(String collection, Object data) async {
    CollectionReference _CR = _fireStore.collection(collection);
    try {
     final value = await _CR.add(data);
     return ApiResult.success(data: value != null ? true : false);
    }
    catch(e){
      print(e);
      return ApiResult.error(errorMsg: "Unable to process information");
    }

  }

  Future<ApiResult<bool>> update(String collection, Object data, String docID) async {
    CollectionReference _CR = _fireStore.collection(collection);
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
      final data = await _fireStore.collection(collection).where(field,isEqualTo: value).limit(1).get();
      return data;
    }
    catch(e){
      print(e);
      return e;
    }

  }

}