// // ocrapi.dart
// import 'dart:convert';
// import 'dart:io';

// import 'package:dio/dio.dart';

// class OCRApi {
//   static final Dio _dio = Dio();

//   static Future<Map<String, dynamic>> sendImageToApi(File imageFile) async {
//     try {
//       FormData formData = FormData.fromMap({
//         'api_key': 'TEST',
//         'recognizer': 'auto',
//         'ref_no': 'ocr_flutter_123',
//         'file': await MultipartFile.fromFile(imageFile.path),
//       });

//       Response response = await _dio.post(
//         'https://ocr.asprise.com/api/v1/receipt',
//         data: formData,
//       );

//       if (response.statusCode == 200) {
//         return json.decode(response.toString());
//       } else {
//         throw Exception(
//             'Error: ${response.statusCode}\nResponse body: ${response.data}');
//       }
//     } catch (error) {
//       throw Exception('Error: $error');
//     }
//   }
// }
