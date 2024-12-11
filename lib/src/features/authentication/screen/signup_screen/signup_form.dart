import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/authentication/controllers/signup_controller.dart';
import 'package:compuvers/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    RxBool obscurePassword = true.obs;
    RxBool obscureConfirmPassword = true.obs;

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name Field
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: cFullName,
                hintText: cFullName,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),

            // Email Field
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: cEmail,
                hintText: cEmail,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),

            // Password Field
            Obx(() {
              return TextFormField(
                controller: controller.password,
                obscureText: obscurePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  labelText: cPwd,
                  hintText: cPwd,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      obscurePassword.value = !obscurePassword.value;
                    },
                    icon: Icon(
                      obscurePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              );
            }),
            const SizedBox(height: 20.0),

            // Confirm Password Field
            Obx(() {
              return TextFormField(
                controller: controller.confirmPassword,
                obscureText: obscureConfirmPassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      obscureConfirmPassword.value = !obscureConfirmPassword.value;
                    },
                    icon: Icon(
                      obscureConfirmPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != controller.password.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              );
            }),
            const SizedBox(height: 20.0),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final user = UserModel(
                      email: controller.email.text.trim().toLowerCase(),
                      fullName: controller.fullName.text.trim(),
                      password: controller.password.text.trim(),
                    );
                    SignUpController.instance.createUser(user);
                  }
                },
                child: Text(cSignUp.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
