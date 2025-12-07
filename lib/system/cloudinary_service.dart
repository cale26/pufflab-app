import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'db_service.dart';

Future<bool> uploadToCloudinary(FilePickerResult? filePickerResult) async {
  if (filePickerResult == null || filePickerResult.files.isEmpty) {
    print("No file selected.");
    return false;
  }

  File file = File(filePickerResult.files.single.path!);

  String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  var uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/raw/upload");

  var request = http.MultipartRequest("POST", uri);
  request.fields['upload_preset'] = "preset-for-file-upload";
  request.fields['resource_type'] = "raw";

  var multipartFile = await http.MultipartFile.fromPath(
    'file',
    file.path,
    filename: file.path.split("/").last,
  );

  request.files.add(multipartFile);

  var response = await request.send();
  var responseBody = await response.stream.bytesToString();

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(responseBody);
    Map<String, String> requiredData = {
      "name": filePickerResult.files.first.name,
      "id": jsonResponse["public_id"],
      "extension": filePickerResult.files.first.extension ?? '',
      "size": jsonResponse["bytes"].toString(),
      "url": jsonResponse["secure_url"],
      "created_at": jsonResponse["created_at"],
    };

    await DbService().saveUploadedFilesData(requiredData);
    print("Upload successful!");
    return true;
  } else {
    print("Upload failed with status: ${response.statusCode}");
    return false;
  }
}
