import 'package:chef/core/error/exception.dart';
import 'package:chef/core/network/end_points.dart';
import 'package:chef/core/utils/error_message_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



abstract class DioHelper {
  Future<dynamic> post({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    String? lang ,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> put({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    String? lang,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    String? lang,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });

  Future<dynamic> patch({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    String? lang,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });
}

class DioHelperImpl implements DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: '$baseApiUrl$version',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 5000),
       validateStatus: (status) => true,
       followRedirects: false,
     // contentType: 'boundary=<calculated when request is sent>'
    ),
  );

  @override
  Future get({
    String? base,
    required String endPoint,
    data,
    query,
    String? token,
    String? lang,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(microseconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      //if (!isMultipart) 'lang': language,
      if (token != null) 'token': token,
    };

    debugPrint('URL => ${dio.options.baseUrl + endPoint}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      call: () async => await dio.get(
        endPoint,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future post({
    String? base,
    required String endPoint,
    data,
    query,
    String? token,
    String? lang,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(microseconds: timeOut);
    }

    // dio.options.headers = {
    //   if (isMultipart) 'Content-Type': 'multipart/form-data',
    //   if (!isMultipart) 'Content-Type': 'application/json',
    //   if (!isMultipart) 'Accept': 'application/json',
    //   //if (!isMultipart) 'lang': language,
    //   if (token != null) 'token': token,
    // };

    debugPrint('URL => ${dio.options.baseUrl + endPoint}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      call: () async => await dio.post(
        endPoint,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future put({
    String? base,
    required String endPoint,
    data, query,
    String? token,
    String? lang,
    ProgressCallback?progressCallback,
    CancelToken?cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(microseconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      //if (!isMultipart) 'lang': language,
      if (token != null) 'token': token,
    };

    debugPrint('URL => ${dio.options.baseUrl + endPoint}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      call: () async => await dio.put(
        endPoint,
        data: data,
        queryParameters: query,
        onSendProgress: progressCallback,
        cancelToken: cancelToken,
      ),
    );
  }

  @override
  Future patch({
    String? base,
    required String endPoint,
    data,
    query,
    String? token,
    String? lang,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(microseconds: timeOut);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      //if (!isMultipart) 'lang': language,
      if (token != null) 'token': token,
    };

    debugPrint('URL => ${dio.options.baseUrl + endPoint}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    return await request(
      call: () async => await dio.get(
        endPoint,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
  }
}

extension on DioHelper {
  Future request({
    required Future<Response> Function() call,
  }) async {
    try {
      final r = await call.call();
      debugPrint('Response_Data => ${r.data}');
      debugPrint('Response_Code => ${r.statusCode}');
      return r.data;
    } on DioException catch (e) {
      debugPrint('Error_Message => ${e.message}');
      debugPrint('Error_Error => ${e.error.toString()}');
      debugPrint('Error_Type => ${e.type.toString()}');

      throw ServerException(
        statusErrorMessageModel: const StatusErrorMessageModel(
          error: 'error message',
          message: 'message Hello from primary exception',
          code: 100,
        ),
      );
    } catch (e) {
      ServerException exception = e as ServerException;
      throw ServerException(
        statusErrorMessageModel: exception.statusErrorMessageModel,
      );
    }
  }
}
