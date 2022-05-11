import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracker/model/profilemodel.dart';

import '../controller/signupcontroller.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> signupForm = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController conformPasswordController = TextEditingController();

  bool passwordHidded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: signupForm,
          child: ListView(
            children: [
              Text(
                "Create your account",
                style: GoogleFonts.ubuntu(
                  fontSize: 50,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Let's get started.",
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 50),
              const Text("Enter Username"),
              const SizedBox(height: 10),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.account_circle,
                  ),
                  hintText: "Enter username",
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Enter username";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text("Enter your email address"),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.mail,
                  ),
                  hintText: "Enter your email address",
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Email address";
                  }
                  if (!value.toString().isEmail) {
                    return "Enter valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text("Enter mobile number"),
              const SizedBox(height: 10),
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.location_city,
                  ),
                  hintText: "Enter mobile number",
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Enter your mobile number";
                  }
                  if (!value.toString().isNumericOnly) {
                    return "Enter valid phone number";
                  }
                  if (value.toString().length != 10) {
                    return "Enter valid phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text("Enter password"),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: passwordHidded,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.password,
                  ),
                  suffixIcon: IconButton(
                      icon: passwordHidded
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          passwordHidded = !passwordHidded;
                        });
                      }),
                  hintText: "Enter Password",
                  fillColor: Colors.grey.shade200,
                  filled: true,
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Password cannot be empty";
                  }
                  if (value.toString().length < 8) {
                    return "Password cannot be less than 7 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              GetBuilder<SignupController>(
                init: SignupController(),
                initState: (_) {},
                builder: (_) {
                  return ElevatedButton(
                    onPressed: () {
                      if (signupForm.currentState!.validate()) {
                        _.signup(
                          ProfileModel(
                            id: 0,
                            date: DateTime.now().toString(),
                            username: usernameController.text,
                            password: passwordController.text,
                            notificationid: "",
                            email: emailController.text,
                          ),
                          context,
                        );
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: _.signuploading
                          ? const CircularProgressIndicator()
                          : Text("Signup"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
