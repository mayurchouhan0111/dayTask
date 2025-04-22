

import 'package:daytask/theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SettingsScreen extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: AnimationLimiter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                _buildThemeSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appearance',
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Obx(() => Column(
            children: [
              _buildThemeOption(
                context,
                'System Theme',
                'Follow system theme settings',
                Icons.brightness_auto,
                themeController.themeMode.value == ThemeMode.system,
                    () => themeController.changeThemeMode(ThemeMode.system),
              ),
              Divider(height: 1),
              _buildThemeOption(
                context,
                'Light Theme',
                'Always use light theme',
                Icons.light_mode,
                themeController.themeMode.value == ThemeMode.light,
                    () => themeController.changeThemeMode(ThemeMode.light),
              ),
              Divider(height: 1),
              _buildThemeOption(
                context,
                'Dark Theme',
                'Always use dark theme',
                Icons.dark_mode,
                themeController.themeMode.value == ThemeMode.dark,
                    () => themeController.changeThemeMode(ThemeMode.dark),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget _buildThemeOption(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      bool isSelected,
      VoidCallback onTap
      ) {
    return ListTile(
      leading: Icon(
          icon,
          color: isSelected ? Theme.of(context).colorScheme.primary : null
      ),
      title: Text(
        title,
        style: GoogleFonts.spaceGrotesk(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.spaceGrotesk(fontSize: 12),
      ),
      trailing: isSelected ? Icon(
          Icons.check,
          color: Theme.of(context).colorScheme.primary
      ) : null,
      onTap: onTap,
    );
  }
}