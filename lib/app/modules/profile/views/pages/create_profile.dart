import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/modules/profile/controller/profile_controller.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileController>(
      builder: (controller) => Form(
        key: controller.globalKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            semesterTextField(controller.semester),
            SizedBox(
              height: 20,
            ),
            LocationTextField(controller.location),
            SizedBox(
              height: 20,
            ),
            aboutTextField(controller.about),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                controller.submit();
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
            radius: 80.0,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60")),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: Get.context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return GetBuilder<ProfileController>(
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

  Widget semesterTextField(TextEditingController semesterController) {
    return TextFormField(
      controller: semesterController,
      validator: (value) {
        if (value.isEmpty) return "semester can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: "Semester",
        helperText: "Semester can't be empty",
        hintText: "3rd",
      ),
    );
  }

  Widget LocationTextField(TextEditingController locationController) {
    return TextFormField(
      controller: locationController,
      validator: (value) {
        if (value.isEmpty) return "City name can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.teal,
        ),
        labelText: "city",
        helperText: "It can't be empty",
        hintText: "Bihar",
      ),
    );
  }

  Widget aboutTextField(TextEditingController aboutController) {
    return TextFormField(
      controller: aboutController,
      validator: (value) {
        if (value.isEmpty) return "About can't be empty";

        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: "About",
        helperText: "Write about yourself",
        hintText: "I am Dev Stack",
      ),
    );
  }
}
