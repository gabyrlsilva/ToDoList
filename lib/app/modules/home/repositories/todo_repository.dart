import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/app/modules/home/models/todo_model.dart';
import 'package:todo/app/modules/home/repositories/todo_repository_interface.dart';

class TodoRepository implements TodoRepositoryInterface {
  final Firestore firestore;

  TodoRepository(this.firestore);

  @override
  Stream<List<TodoModel>> getTodo() {
    return firestore
        .collection('todo')
        .orderBy('position')
        .snapshots()
        .map((query) {
      return query.documents.map((doc) {
        return TodoModel.fromDocument(doc);
      }).toList();
    });
  }
}
