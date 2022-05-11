import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:period_tracker/controller/logincontroller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool passwordHidded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: loginForm,
          child: ListView(
            children: [
              Center(
                child: Text(
                  "",
                  style: GoogleFonts.lobster(
                      fontSize: 30,
                      color: Color.fromARGB(255, 39, 27, 9),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                'assets/Klogo.png',
                height: 150,
              ),
              const SizedBox(height: 10),
              const Text("Email"),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  fillColor: Color.fromARGB(255, 211, 180, 172),
                  filled: true,
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Please Fill Your Email Address";
                  }
                  if (!value.toString().isEmail) {
                    return "Please Enter Valid Email Address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Text("Password"),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: passwordHidded,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                      icon: passwordHidded
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          passwordHidded = !passwordHidded;
                        });
                      }),
                  hintText: "Password",
                  fillColor: Color.fromARGB(255, 211, 180, 172),
                  filled: true,
                ),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Plassword cannot be less then 7 digits";
                  }
                  return null;
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgotpassword');
                },
                child: Text("Forgot Password"),
              ),
              const SizedBox(height: 40),
              GetBuilder<LoginController>(
                init: LoginController(),
                initState: (_) {},
                builder: (_) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (loginForm.currentState!.validate()) {
                          _.login(
                            emailController.text,
                            passwordController.text,
                            context,
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Login"),
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Signup"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
