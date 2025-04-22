import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoRotation;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:  Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoRotation = Tween<double>(begin: 0.0, end: 0.05)
        .animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut)));

    _buttonScale = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0, curve: Curves.elasticOut)));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF232733),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: AnimationLimiter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: AnimationConfiguration.toStaggeredList(
                duration:  Duration(milliseconds: 1200),
                delay:  Duration(milliseconds: 300),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 100.0,
                  curve: Curves.easeOutQuart,
                  child: FadeInAnimation(
                    curve: Curves.easeOut,
                    child: widget,
                  ),
                ),
                children: [
                  // Logo with rotation animation
                  AnimatedBuilder(
                      animation: _logoRotation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _logoRotation.value,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:  EdgeInsets.only(top: 24.0, left: 20.0, bottom: 20.0),
                              child: Hero(
                                tag: 'logo',
                                child: Image.asset('assets/logo.png', height: 70),
                              ),
                            ),
                          ),
                        );
                      }
                  ),

                  // Illustration with parallax effect
                  TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: -30.0, end: 0.0),
                      duration:  Duration(milliseconds: 1500),
                      curve: Curves.easeOutQuad,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(value, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:  EdgeInsets.only(top: 8.0, right: 20),
                              child: Image.asset(
                                'assets/illustration.png',
                                height: 250,
                                width: double.maxFinite,
                              ),
                            ),
                          ),
                        );
                      }
                  ),

                  // Text animation with character-by-character effect
                  Padding(
                    padding:  EdgeInsets.only(top: 24.0, left: 12, right: 12),
                    child: Column(
                      children: [
                        DefaultTextStyle(
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              height: 1.3
                          ),
                          child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'Manage your Task with',
                                speed: Duration(milliseconds: 80),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),

                        // Animated logo text
                        TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration:  Duration(milliseconds: 800),
                            curve: Curves.elasticOut,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ShaderMask(
                                    shaderCallback: (bounds) {
                                      return LinearGradient(
                                        colors: [
                                          Color(0xFFFFC107),
                                          Color(0xFFFFD54F),
                                          Color(0xFFFFC107),
                                        ],
                                        stops: [0.2, 0.5, 0.8],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds);
                                    },
                                    child: Text(
                                      'DayTask',
                                      style: GoogleFonts.spaceGrotesk(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ],
                    ),
                  ),

                  // Button with elastic animation
                  Padding(
                    padding:  EdgeInsets.only(top: 32.0, left: 16, right: 16, bottom: 24),
                    child: AnimatedBuilder(
                        animation: _buttonScale,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _buttonScale.value,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:  Color(0xFFFFC107),
                                  foregroundColor: Colors.black,
                                  padding:  EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  elevation: 3,
                                  shadowColor: Colors.black.withOpacity(0.3),
                                ),
                                onPressed: () {
                                  // Button press animation
                                  HapticFeedback.mediumImpact();

                                  // Create ripple animation effect
                                  final RenderBox box = context.findRenderObject() as RenderBox;
                                  final Offset position = box.localToGlobal(Offset.zero);
                                  final double x = position.dx;
                                  final double y = position.dy;

                                  // Navigate with page transition
                                  final user = Supabase.instance.client.auth.currentUser;
                                  if (user != null) {
                                    Get.offAllNamed('/dashboard');
                                  } else {
                                    Get.offAllNamed('/login');
                                  }
                                },
                                child: Text(
                                    "Let's Start",
                                    style: GoogleFonts.spaceGrotesk(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}