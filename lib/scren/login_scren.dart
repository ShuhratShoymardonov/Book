import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myflutter_book/widget/navigation_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibility = true;
  bool isLoading = false;
  var storage = const FlutterSecureStorage();
  final emailController = TextEditingController(text: "admin");
  final passwordController = TextEditingController(text: "12345");

  Future<void> loginMethod(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse("http://65.108.148.136:8087/api/Auth/Login"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "userName": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (jsonDecode(response.body)['statusCode'] == 200) {
        var responseBody = jsonDecode(response.body);
        var token = responseBody['token'];
        await storage.write(key: 'token', value: token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Navigations(),
            
          ),
        );
      } else {
        var responseBody = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Failed to login: ${responseBody['errors'].toString().replaceAll(RegExp(r'[\[\]"]'), '')}",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to load data: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 2, 69, 124),
                  Color.fromARGB(255, 6, 57, 99),
                  Color.fromARGB(255, 4, 20, 34),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Login to read and learn",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    inputField(name: "Email", controller: emailController),
                    inputField(
                      visibility: visibility,
                      name: "Password",
                      controller: passwordController,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        icon: Icon(
                          visibility
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    InkWell(
                      hoverColor: const Color.fromARGB(255, 7, 105, 185),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.94,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 2, 69, 124),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      onTap: () {
                        loginMethod(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget inputField({
    required String name,
    required TextEditingController controller,
    Widget? icon,
    bool visibility = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        obscureText: visibility,
        decoration: InputDecoration(
          suffixIcon: icon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          labelText: name,
          labelStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
