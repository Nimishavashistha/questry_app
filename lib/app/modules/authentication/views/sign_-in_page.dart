import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/global_widgets/custom_button.dart';
import 'package:questry/app/global_widgets/custom_text_field.dart';
import 'package:questry/app/global_widgets/glassmorphism_container.dart';
import 'package:questry/app/modules/authentication/views/forgot-password.dart';
import '../../../data/User.dart';
import '../controller/auth_controller.dart';
import '../../../routes/routes_management.dart';

class SignInPage extends StatelessWidget {
  User user = User('', '');
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
                      GlassMorphismContainer(
                        height: Get.height * 0.65,
                        width: Get.width * 0.8,
                        child: Column(
                          children: [
                            Spacer(),
                            Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            CustomTextField(
                                controller: TextEditingController(
                                    text: controller.user.email),
                                onchanged: (value) {
                                  controller.user.email = value;
                                },
                                validationFun: (value) =>
                                    controller.emailvalidation(value),
                                hintText: "Email",
                                errortext: controller.validate_signin
                                    ? null
                                    : controller.errorText,
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
                              errortext: controller.validate_signin
                                  ? null
                                  : controller.errorText,
                              suffixIcon: IconButton(
                                icon: Icon(controller.vis_signin
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                color: Colors.white,
                                onPressed: () {
                                  controller.changeVisSign();
                                },
                              ),
                              isObscure: controller.vis_signin,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            CustomButton(
                              circular: controller.circular_signin,
                              buttonName: "Sign In",
                              onPress: () {
                                controller.submitSignIn();
                              },
                              paddingH: 25.0,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          RoutesManagement.goToSignUpScreen();
                        },
                        child: GlassMorphismContainer(
                          height: 50.0,
                          width: Get.width * 0.8,
                          borderRadius: 10.0,
                          child: Center(
                            child: Text(
                              "Don't have an account? Sign Up.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("going to forgot pass");
                          RoutesManagement.goToForgotPasswordScreen();
                        },
                        child: GlassMorphismContainer(
                          height: 50.0,
                          width: Get.width * 0.8,
                          borderRadius: 10.0,
                          child: Center(
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
