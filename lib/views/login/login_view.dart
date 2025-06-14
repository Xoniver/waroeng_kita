// ignore_for_file: unused_field

import 'package:flutter/material.dart';

import '../../global_widget/custom_textfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          // Bagian atas: logo dan background
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1D4AAA), Color(0xFF7DC3F7)],
                ),
              ),
              child: Center(
                child: Image.asset('assets/images/logo.png', width: 200),
              ),
            ),
          ),

          // Bagian bawah: form login
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/onboarding',
                                        (route) => false,
                                  );
                                },
                                child: Row(
                                  children: const [
                                    Icon(Icons.arrow_back, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            CustomTextField(
                              label: 'Email',
                              controller: emailController,
                              isPassword: false,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              label: 'Password',
                              controller: passwordController,
                              isPassword: true,


                            ),

                            const Spacer(),

                            // Tombol Login
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: Proses login
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/navigation-bar', (
                                      route) => false);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1D4AAA),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 3,
                                ),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
