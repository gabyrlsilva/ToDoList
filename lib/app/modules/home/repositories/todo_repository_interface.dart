import 'package:todo/app/modules/home/models/todo_model.dart';

abstract class TodoRepositoryInterface {
  Stream<List<TodoModel>> getTodo();

  Future save(TodoModel model);

  Future delete(TodoModel model);
}
