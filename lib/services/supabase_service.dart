import 'package:supabase_flutter/supabase_flutter.dart';
import '../dashboard/task_model.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<Task>> fetchTasks(String userId) async {
    final res = await client
        .from('tasks')
        .select()
        .eq('user_id', userId)
        .order('id', ascending: false);
    return (res as List)
        .map((json) => Task.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> addTask(String userId, String title) async {
    await client.from('tasks').insert({
      'user_id': userId,
      'title': title,
      'completed': false,
    });
  }
  Future<void> updateTaskTitle(String id, String newTitle) async {
    await client
        .from('tasks')
        .update({'title': newTitle})
        .eq('id', id);
  }


  Future<void> deleteTask(String taskId) async {
    await client.from('tasks').delete().eq('id', taskId);
  }

  Future<void> toggleTaskComplete(String taskId, bool completed) async {
    await client.from('tasks').update({'completed': completed}).eq('id', taskId);
  }
}
