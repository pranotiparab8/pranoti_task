import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyController extends GetxController {
  var isImagePicked = false.obs;
  PickedFile? pickedFile;
  void getFromCamera() async {
    isImagePicked.value = true;
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 100,
      maxHeight: 100,
    );
    isImagePicked.refresh();
    if (pickedFile != null) {
      // isImagePicked.value = true;
      //  setState(() {});
    }
  }

  _getFromCamera() async {
    //isImagePicked.value = true;
    pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 100,
      maxHeight: 100,
    );
    if (pickedFile != null) {
      // isImagePicked.value = true;
      //  setState(() {});
    }
  }
}
