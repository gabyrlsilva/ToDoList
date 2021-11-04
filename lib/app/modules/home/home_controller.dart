import 'package:mobx/mobx.dart';
import 'package:todo/app/modules/home/models/todo_model.dart';
import 'package:todo/app/modules/home/repositories/todo_repository_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final TodoRepositoryInterface repository;

  @observable
  ObservableStream<List<TodoModel>> todoList;

  _HomeControllerBase(this.repository) {
    getList();
  }

  @action
  getList() {
    todoList = repository.getTodo().asObservable();
  }

  save(TodoModel model) => repository.save(model);
  delete(TodoModel model) => repository.delete(model);
}
