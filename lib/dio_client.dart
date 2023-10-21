import 'package:dio/dio.dart';
class DioClient{
  // final  dio = Dio();
  final Dio dio;
  DioClient(this.dio);
  Future<Response> request(Map<String,String>? queryParameters,RequestType requestType,String url) async{
    Response response;
    try{
      switch(requestType){
        case RequestType.post:
          response  = await dio.post(url,data: queryParameters);
          break;
        case RequestType.get:
          response = await dio.get(url,queryParameters: queryParameters);
          break;
      }
    }on DioException catch(e){
      response = Response(requestOptions: RequestOptions(),statusCode: 999,statusMessage: e.message);
    }
    return response;
  }
}
enum RequestType{
  get,
  post,
}