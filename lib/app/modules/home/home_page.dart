import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo/app/modules/home/home_controller.dart';
import 'package:todo/app/modules/home/models/todo_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Observer(builder: (_) {
        if (controller.todoList.hasError) {
          return Center(
            child: ElevatedButton(
              onPressed: controller.getList(),
              child: const Text('Error'),
            ),
          );
        }

        if (controller.todoList.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<TodoModel> list = controller.todoList.data;
        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              TodoModel model = list[index];
              return ListTile(
                title: Text(model.title),
                onTap: () {
                  _showDialog(model);
                },
                leading: IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red,
                  ),
                  onPressed: model.delete(),
                ),
                trailing: Checkbox(
                  value: model.check,
                  onChanged: (check) {
                    model.check = check!;
                    model.save();
                  },
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _showDialog([TodoModel? model]) {
    model ??= TodoModel();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(model!.title.isEmpty ? 'Novo' : 'Edição'),
            content: TextFormField(
              initialValue: model.title,
              onChanged: (value) => model!.title = value,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'escreve...',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Modular.to.pop();
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  await model!.save();
                  Modular.to.pop();
                },
                child: const Text('Salvar'),
              )
            ],
          );
        });
  }
}
