import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questry/app/constants/colors.dart';
import 'package:questry/app/global_widgets/custom_button.dart';
import 'package:questry/app/global_widgets/custom_text_field.dart';
import 'package:questry/app/global_widgets/glassmorphism_container.dart';
import '../../../data/User.dart';
import '../controller/auth_controller.dart';
import '../../../routes/routes_management.dart';

class ForgotPasswordPage extends StatelessWidget {
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
                              "Forgot Password",
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
                              height: 20.0,
                            ),
                            CustomButton(
                              circular: controller.circular_signin,
                              buttonName: "Update Password",
                              onPress: () async {
                                await controller.UpdatePassword();
                              },
                              paddingH: 25.0,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
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
