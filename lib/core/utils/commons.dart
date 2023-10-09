import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';


Future<XFile?> pickImage(ImageSource source) async {
  XFile? image = await ImagePicker().pickImage(source: source);
  if (image != null) {
    return image;
  } else {
    return null;
  }
}

Future uploadImageToAPI(XFile image) async {
  return MultipartFile.fromFileSync(image.path,
      filename: image.path.split('/').last,
  );
}
