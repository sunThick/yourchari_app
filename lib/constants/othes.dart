// intとかString以外のものreturn
// package
import 'package:image_picker/image_picker.dart';
 
Future<XFile> returnXFile() async {
  final ImagePicker picker = ImagePicker();
    // Pick an image
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image!;
}