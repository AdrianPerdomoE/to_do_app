import 'package:flutter/material.dart';

import '../models/task.dart';

class EditTask extends StatefulWidget {
  Task currentTask;
  EditTask({super.key, required this.currentTask});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late String title;
  late String description;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    setState(() {
      title = widget.currentTask.title;
      description = widget.currentTask.description;
    });
    return AlertDialog(
      title: const Text('Editar tarea'),
      content: SizedBox(
        height: 150,
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              initialValue: title,
              validator: (value) => validateInput(value!),
              onSaved: (newValue) {
                title = newValue!;
              },
              decoration: const InputDecoration(
                  hintText: "Ingresa un titulo", label: Text('Titulo')),
            ),
            TextFormField(
              initialValue: description,
              validator: (value) => validateInput(value!),
              onSaved: (newValue) {
                description = newValue!;
              },
              decoration: const InputDecoration(
                hintText: "Ingresa una descripción",
                label: Text('Descripción'),
              ),
            )
          ]),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              setState(() {
                widget.currentTask.description = description;
                widget.currentTask.title = title;
              });
              Navigator.pop(context);
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }

  validateInput(String value) {
    return value.isNotEmpty ? null : "Campo requerido";
  }
}
