// ignore_for_file: unused_field

import 'package:flutter/material.dart';

import '../../global_widget/custom_textfield_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
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
          // Bagian atas: background gradient dan logo
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

          // Bagian bawah: Form register
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
                            // Title dan Back Button
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
                                      'Register',
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


                            // Nama Lengkap
                            CustomTextField(
                              label: 'Nama Lengkap',
                              controller: nameController,
                              isPassword: false,
                            ),
                            const SizedBox(height: 16),

                            // Email
                            CustomTextField(
                              label: 'Email',
                              controller: emailController,
                              isPassword: false,
                            ),
                            const SizedBox(height: 16),

                            // Password
                            CustomTextField(
                                label: 'Password',
                                controller: passwordController,
                                isPassword: true),


                            const Spacer(),

                            // Tombol Register
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/alamat', (route) => false);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5CB661),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 3,
                                ),
                                child: const Text(
                                  'Register',
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
          )
        ],
      ),
    );
  }

}
