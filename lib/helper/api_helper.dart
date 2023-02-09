import 'dart:convert';
import 'package:http/http.dart' as http;

class APIHelper
{
   APIHelper._();

   static final APIHelper apiHelper = APIHelper._();

   String baseURL = "https://jsonplaceholder.typicode.com";
   String endpoint = "/users/1";

  Future <Map?> getData() async{
     String api = baseURL + endpoint;
     http.Response data = await http.get(Uri.parse(api));

     if(data.statusCode == 200)
        {
          Map decodeData = jsonDecode(data.body);
           return decodeData;
        }
     return null;
   }
}