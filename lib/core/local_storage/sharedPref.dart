import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
   SharedPreferences _prefs;
  
  SharedPref(){
    init();
  }

  Future<void> init () async{
    _prefs = await SharedPreferences.getInstance();
  }
  read(String key){
   // final prefs = await SharedPreferences.getInstance();
    return json.decode(_prefs.getString(key));
  }


   save(String key, value){
   // final prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, jsonEncode(value));
  }


   remove(String key){
   // final prefs = await SharedPreferences.getInstance();
    _prefs.remove(key);
  }

   check(String key){
    //final prefs = await SharedPreferences.getInstance();
    return _prefs.containsKey(key);
  }

   storeInt(String key, value){
    //final prefs = await SharedPreferences.getInstance();
    _prefs.setInt(key, value);
  }


   getInt(String key) {
   // final prefs = await SharedPreferences.getInstance();
    return _prefs.getInt(key);
  }

   storeBool(String key, value) {
    //final prefs = await SharedPreferences.getInstance();
    _prefs.setBool(key, value);
  }


   getBool(String key) {
   // final prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(key);
  }



}