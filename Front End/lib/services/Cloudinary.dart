
import 'package:flutter/foundation.dart' ;

class CloudImage with ChangeNotifier{
 dynamic _response;
 late List<String> _urlList;
 bool _isloading = true ;
 dynamic get urlList => _urlList;
 String get response => _response;
 bool get isloading => _isloading;
Future<void> upload(List<String> imagesList) async{

 }
}