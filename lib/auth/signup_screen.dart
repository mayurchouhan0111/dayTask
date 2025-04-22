import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_controller.dart';
import '../utils/validators.dart';
class SignupScreen extends StatefulWidget {
   SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor:  Color(0xFF232733),
      body: Center(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(vertical: 24.0),
          child: Container(
            width: 340,
            padding:  EdgeInsets.all(24),
            decoration: BoxDecoration(
              color:  Color(0xFF1A1D23),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: _formKey,
              child: AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration:  Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Image.asset('assets/logo.png', height: 48),
                             SizedBox(height: 6),
                            Text(
                              'DayTask',
                              style:  GoogleFonts.spaceGrotesk(
                                color: Color(0xFFFFC107),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                       SizedBox(height: 18),
                       Text(
                        'Create your account',
                        style:  GoogleFonts.spaceGrotesk(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                       SizedBox(height: 18),
                       Text('Full Name', style:  GoogleFonts.spaceGrotesk(color: Colors.grey, fontSize: 14)),
                       SizedBox(height: 4),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:  Color(0xFF232733),
                          hintText: 'Name',
                          hintStyle:   GoogleFonts.spaceGrotesk(color: Colors.white70),
                          prefixIcon:  Icon(Icons.person, color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                        style:   GoogleFonts.spaceGrotesk(color: Colors.white),
                      ),
                       SizedBox(height: 12),
                       Text('Email Address', style:  GoogleFonts.spaceGrotesk(color: Colors.grey, fontSize: 14)),
                       SizedBox(height: 4),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:  Color(0xFF232733),
                          hintText: 'Email',
                          hintStyle:   GoogleFonts.spaceGrotesk(color: Colors.white70),
                          prefixIcon:  Icon(Icons.email, color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                        style:   GoogleFonts.spaceGrotesk(color: Colors.white),
                        validator: Validators.validateEmail,
                      ),
                       SizedBox(height: 12),
                       Text('Password', style:  GoogleFonts.spaceGrotesk(color: Colors.grey, fontSize: 14)),
                       SizedBox(height: 4),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isPasswordHidden,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:  Color(0xFF232733),
                          hintText: 'Password',
                          hintStyle:   GoogleFonts.spaceGrotesk(color: Colors.white70),
                          prefixIcon:  Icon(Icons.lock, color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                        style:   GoogleFonts.spaceGrotesk(color: Colors.white),
                        validator: Validators.validatePassword,
                      ),
                       SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (v) {}),
                           Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: 'I have read & agreed to ',
                                style:  GoogleFonts.spaceGrotesk(color: Colors.grey, fontSize: 12),
                                children: [
                                  TextSpan(
                                    text: 'DayTask Privacy Policy, Terms & Condition.',
                                    style:  GoogleFonts.spaceGrotesk(color: Color(0xFFFFC107), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                       SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color(0xFFFFC107),
                            foregroundColor: Colors.black,
                            padding:  EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authController.signUp(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                          child:  Text('Sign Up', style:  GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                       SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade700)),
                           Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('Or continue with', style:  GoogleFonts.spaceGrotesk(color: Colors.grey)),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade700)),
                        ],
                      ),
                       SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side:  BorderSide(color: Color(0xFFFFC107)),
                            padding:  EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {}, // Add Google Sign-In logic here
                          icon:  Icon(Icons.g_mobiledata, color: Color(0xFFFFC107)),
                          label:  Text('Google', style:  GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold)),
                        ),
                      ),
                       SizedBox(height: 24),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account? ', style:  GoogleFonts.spaceGrotesk(color: Colors.grey)),
                            GestureDetector(
                              onTap: () => Get.toNamed('/login'),
                              child: Text('Log In', style:  GoogleFonts.spaceGrotesk(color: Color(0xFFFFC107), fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
