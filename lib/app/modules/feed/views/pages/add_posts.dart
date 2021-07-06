import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:questry/app/global_widgets/overlay_card.dart';
import 'package:questry/app/modules/feed/controller/feed_controller.dart';

class AddPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white54,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            TextButton(
                onPressed: () {
                  if (controller.imageFile != null &&
                      controller.globalkey.currentState.validate()) {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => OverlayCard(
                              imagefile: controller.imageFile,
                              desc: controller.desc.text,
                            )));
                  }
                },
                child: Text(
                  "Preview",
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ))
          ],
        ),
        body: Form(
          key: controller.globalkey,
          child: ListView(
            children: <Widget>[
              bodyTextField(controller.desc),
              // titleTextField(),
              SizedBox(
                height: 20,
              ),
              addButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget titleTextField(TextEditingController text) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(
//       horizontal: 10,
//       vertical: 10,
//     ),
//     child: TextFormField(
//         maxLength: 100,
//         maxLines: null,
//         controller: _title,
//         validator: (value) {
//           if (value.isEmpty) {
//             return "Title can't be empty";
//           } else if (value.length > 100) {
//             return "Title length should be <=100";
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.teal,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.orange,
//               width: 2,
//             ),
//           ),
//           labelText: "Add Image and Title",
//         )),
//   );
// }

Widget bottomSheet(BuildContext context) {
  return GetBuilder<FeedController>(
    builder: (controller) => Container(
      height: 100.0,
      width: MediaQuery.of(Get.context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                controller.takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                controller.takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    ),
  );
}

Widget bodyTextField(TextEditingController body) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    child: TextFormField(
      controller: body,
      validator: (value) {
        if (value.isEmpty) {
          return "Body can't be empty";
        }
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
          ),
          labelText: "What's your doubt?",
          suffixIcon: IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              showModalBottomSheet(
                  context: Get.context,
                  builder: (builder) => bottomSheet(Get.context));
            },
          )),
      maxLines: null,
    ),
  );
}

Widget addButton() {
  return GetBuilder<FeedController>(
    builder: (controller) => InkWell(
      onTap: () {
        controller.submit();
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal),
          child: Center(
              child: Text(
            "Add Post",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    ),
  );
}
