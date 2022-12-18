import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static Dio getApiHandler() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/",
    );

    // if (token != '') options.headers["Authorization"] = "Bearer " + token;

    options.headers["Accept"] = "application/json";
    // isFormData ? options.headers['Content-Type'] = 'multipart/form-data' : null;

    Dio dio = Dio(options);
    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      )
    ]);

    return dio;
  }
}
