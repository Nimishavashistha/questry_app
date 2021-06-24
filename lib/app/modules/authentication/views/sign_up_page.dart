import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/global_widgets/custom_button.dart';
import 'package:questry/app/global_widgets/custom_text_field.dart';
import 'package:questry/app/global_widgets/glassmorphism_container.dart';
import 'package:questry/app/modules/authentication/controller/auth_controller.dart';

class GMSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  tealBack,
                  purpleBack,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: GetBuilder<AuthController>(
              builder: (controller) => Form(
                key: controller.formKey,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: Get.width * 0.075),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: GlassMorphismContainer(
                                height: 60.0,
                                width: 60.0,
                                borderRadius: 10.0,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Spacer(),
                            GlassMorphismContainer(
                              height: 60.0,
                              width: 60.0,
                              borderRadius: 10.0,
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: Get.width * 0.075),
                          ],
                        ),
                        GlassMorphismContainer(
                          height: Get.height * 0.65,
                          width: Get.width * 0.8,
                          child: Column(
                            children: [
                              Spacer(),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              userNameTextField(),
                              CustomTextField(
                                  controller: TextEditingController(
                                      text: controller.user.email),
                                  validationFun: (value) =>
                                      controller.emailvalidation(value),
                                  onchanged: (value) {
                                    controller.user.email = value;
                                  },
                                  hintText: "Email",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  )),
                              CustomTextField(
                                controller: TextEditingController(
                                    text: controller.user.password),
                                onchanged: (value) {
                                  controller.user.password = value;
                                },
                                validationFun: (value) =>
                                    controller.passValidation(value),
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  icon: Icon(controller.vis_signup
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: Colors.white,
                                  onPressed: () {
                                    controller.changeVis();
                                  },
                                ),
                                isObscure: controller.vis_signup,
                              ),
                              SizedBox(height: 10.0),
                              CustomButton(
                                circular: controller.circular_signup,
                                buttonName: "Sign Up",
                                onPress: () {
                                  controller.submitSignUp();
                                },
                                paddingH: 35.0,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Text(
                          "By Signing Up, you are accepting our terms and conditions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget userNameTextField() {
    return GetBuilder<AuthController>(
      builder: (controller) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        margin: EdgeInsets.all(16.0),
        child: TextFormField(
          autofocus: true,
          controller: TextEditingController(text: controller.user.username),
          onChanged: (value) {
            controller.user.username = value;
          },
          validator: (value) => controller.usernameValidation(value),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          decoration: InputDecoration(
            errorText: controller.validate_signup ? null : controller.errorText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                borderSide: BorderSide(color: Colors.white)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
                borderSide: BorderSide(color: Colors.red)),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                print(controller.errorText);
                print("validate=${controller.validate_signup}");
              },
            ),
            hintText: "Username",
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 18.0,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
