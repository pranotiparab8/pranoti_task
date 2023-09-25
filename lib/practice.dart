import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Practice extends StatelessWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Snackbar")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.snackbar("Snackbar Title", "This will be snackbar message");
              },
              child: const Text("Show Dialog"),
            )
          ],
        ),
      ),
    );
  }
}
