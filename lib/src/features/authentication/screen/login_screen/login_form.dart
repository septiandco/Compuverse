import 'package:compuvers/src/constants/text_strings.dart';
import 'package:flutter/material.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: cEmail,
                hintText: cEmail,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline_rounded),
                labelText: cPwd,
                hintText: cPwd,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null, 
                  icon: Icon(Icons.remove_red_eye_sharp)
                )
              ),
            ),
            const SizedBox(height: 5.0,),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){}, 
                child: const Text(cForgotPwd),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){}, 
                child: Text(cLogin.toUpperCase())
              ),
            )
          ],
        ),
      )
    );
  }
}