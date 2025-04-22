import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_controller.dart';
import '../utils/validators.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      backgroundColor:   Color(0xFF232733),
      body: Center(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: AnimationLimiter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration:  Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    curve: Curves.easeOut,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: AnimationConfiguration.toStaggeredList(
                    duration:  Duration(milliseconds: 500),
                    delay:  Duration(milliseconds: 100),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      Center(child: Image.asset('assets/logo.png', height: 80)),
                       SizedBox(height: 32),
                       Text(
                        'Welcome Back!',
                        style: GoogleFonts.spaceGrotesk(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                       SizedBox(height: 24),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:  Color(0xFF2D3142),
                          hintText: 'Email Address',
                          hintStyle:  GoogleFonts.spaceGrotesk(color: Colors.grey),
                          prefixIcon:  Icon(Icons.email, color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                        ),
                        style:  GoogleFonts.spaceGrotesk(color: Colors.white),
                        validator: Validators.validateEmail,
                      ),
                       SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:  Color(0xFF2D3142),
                          hintText: 'Password',
                          hintStyle:  GoogleFonts.spaceGrotesk(color: Colors.grey),
                          prefixIcon:  Icon(Icons.lock, color: Colors.grey),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                          suffixIcon: TextButton(
                            onPressed: () {},
                            child:  Text('Forgot Password?', style: GoogleFonts.spaceGrotesk(color: Colors.grey, fontSize: 12)),
                          ),
                        ),
                        style:  GoogleFonts.spaceGrotesk(color: Colors.white),
                        validator: Validators.validatePassword,
                      ),
                       SizedBox(height: 24),
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
                              authController.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                          child:  Text('Log in', style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                       SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade700)),
                           Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('or continue with', style: GoogleFonts.spaceGrotesk(color: Colors.grey)),
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
                          onPressed: () {},
                          icon:  Icon(Icons.g_mobiledata, color: Color(0xFFFFC107)),
                          label:  Text('Google', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold)),
                        ),
                      ),
                       SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("Don't have an account? ", style: GoogleFonts.spaceGrotesk(color: Colors.grey)),
                          GestureDetector(
                            onTap: () => Get.toNamed('/signup'),
                            child:  Text('Sign Up', style: GoogleFonts.spaceGrotesk(color: Color(0xFFFFC107), fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    )
    )
    );
  }
}
