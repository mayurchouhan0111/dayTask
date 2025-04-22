import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/ThemeController.dart';
import 'dashboard_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final ThemeController themeController = Get.find<ThemeController>();

  void _showTaskDialog(BuildContext context, {String? taskId, String? initialTitle}) {
    final TextEditingController titleController = TextEditingController(text: initialTitle);
    final bool isEditing = taskId != null;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  isEditing ? 'Edit Task' : 'Add New Task',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: themeController.isDarkMode
                      ? const Color(0xFF2A2A2E)
                      : Colors.grey.shade100,
                  hintText: 'Enter task title',
                  hintStyle: GoogleFonts.spaceGrotesk(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                style: GoogleFonts.spaceGrotesk(color: Theme.of(context).colorScheme.onSurface),
                autofocus: true,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      foregroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.trim().isNotEmpty) {
                        if (isEditing) {
                          controller.updateTaskTitle(taskId, titleController.text.trim());
                        } else {
                          controller.addTask(titleController.text.trim());
                        }
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      isEditing ? 'Update' : 'Add',
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTaskOptions(BuildContext context, String taskId, String taskTitle) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              margin: EdgeInsets.only(bottom: 20),
            ),
            ListTile(
              leading: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.onSurface
              ),
              title: Text(
                'Edit Task',
                style: GoogleFonts.spaceGrotesk(
                    color: Theme.of(context).colorScheme.onSurface
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showTaskDialog(context, taskId: taskId, initialTitle: taskTitle);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text(
                'Delete Task',
                style: GoogleFonts.spaceGrotesk(
                    color: Theme.of(context).colorScheme.onSurface
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context, taskId);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Delete Task',
          style: GoogleFonts.spaceGrotesk(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this task?',
          style: GoogleFonts.spaceGrotesk(
              color: Theme.of(context).colorScheme.onSurface
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.spaceGrotesk(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.deleteTask(taskId);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.spaceGrotesk(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedTheme(
      data: themeController.isDarkMode
          ? ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFFFC107),
          surface: const Color(0xFF1F1F1F),
          background: const Color(0xFF121212),
          onSurface: Colors.white,
          onBackground: Colors.white,
        ),
      )
          : ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFFC107),
          surface: Colors.white,
          background: const Color(0xFFF5F5F5),
          onSurface: Colors.black,
          onBackground: Colors.black,
        ),
      ),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Task Details',
            style: GoogleFonts.spaceGrotesk(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            
            IconButton(
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: Icon(
                  themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  key: ValueKey<bool>(themeController.isDarkMode),
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              tooltip: 'Toggle theme',
              onPressed: () => themeController.toggleTheme(),
            ),
            
            IconButton(
              icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.onBackground
              ),
              onPressed: () => controller.logout(),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary
              ));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 600),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Project Progress',
                          style: GoogleFonts.spaceGrotesk(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        LinearPercentIndicator(
                          lineHeight: 8.0,
                          percent: controller.progress.value,
                          backgroundColor: themeController.isDarkMode
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                          progressColor: Theme.of(context).colorScheme.primary,
                          animation: true,
                          animationDuration: 1000,
                          barRadius: Radius.circular(4),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All Tasks',
                              style: GoogleFonts.spaceGrotesk(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${controller.tasks.where((task) => task.completed).length}/${controller.tasks.length} completed',
                              style: GoogleFonts.spaceGrotesk(
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        final task = controller.tasks[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Dismissible(
                                key: Key(task.id),
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20),
                                  color: Colors.red,
                                  child: Icon(Icons.delete, color: Colors.white),
                                ),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) async {
                                  _showDeleteConfirmation(context, task.id);
                                  return false;
                                },
                                child: GestureDetector(
                                  onLongPress: () => _showTaskOptions(context, task.id, task.title),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              themeController.isDarkMode ? 0.3 : 0.1
                                          ),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        task.title,
                                        style: GoogleFonts.spaceGrotesk(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          decoration: task.completed
                                              ? TextDecoration.lineThrough
                                              : null,
                                          decorationColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                      trailing: Checkbox(
                                        value: task.completed,
                                        onChanged: (_) => controller.toggleTaskComplete(
                                            task.id, !task.completed),
                                        activeColor: Theme.of(context).colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        floatingActionButton: AnimationLimiter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => ScaleAnimation(
                child: FadeInAnimation(child: widget),
              ),
              children: [
                TextButton.icon(
                  onPressed: () => _showTaskDialog(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  icon: const Icon(Icons.add, size: 20),
                  label: Text(
                    'Add Task',
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}