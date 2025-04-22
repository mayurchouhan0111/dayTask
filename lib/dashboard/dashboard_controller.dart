import 'package:get/get.dart';
import '../services/supabase_service.dart';
import 'task_model.dart';
import '../auth/auth_controller.dart';

class DashboardController extends GetxController {
  final SupabaseService _service = SupabaseService();
  final AuthController _auth = Get.find<AuthController>();
  RxList<Task> tasks = <Task>[].obs;
  RxBool isLoading = false.obs;

  
  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  
  void _calculateProgress() {
    if (tasks.isEmpty) {
      progress.value = 0.0;
    } else {
      int completedCount = tasks.where((task) => task.completed).length;
      progress.value = completedCount / tasks.length;
    }
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    try {
      final userId = _auth.user.value?.id;
      if (userId != null) {
        tasks.value = await _service.fetchTasks(userId);
        _calculateProgress(); 
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tasks');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTask(String title) async {
    final userId = _auth.user.value?.id;
    if (userId == null) return;
    await _service.addTask(userId, title);
    await fetchTasks(); 
  }

  Future<void> deleteTask(String id) async {
    await _service.deleteTask(id);
    await fetchTasks(); 
  }

  Future<void> toggleTaskComplete(String id, bool completed) async {
    await _service.toggleTaskComplete(id, completed);
    await fetchTasks(); 
  }

  Future<void> updateTaskTitle(String id, String newTitle) async {
    try {
      await _service.updateTaskTitle(id, newTitle);
      await fetchTasks(); 
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task title');
    }
  }

  void logout() => _auth.logout();
}