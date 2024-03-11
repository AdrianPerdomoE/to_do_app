import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  Function(String title, String description) add;
  AddTask({super.key, required this.add});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String title = "";
  String description = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Añadir tarea'),
      content: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) => validateInput(value!),
            onSaved: (newValue) {
              title = newValue!;
            },
            decoration: const InputDecoration(
                hintText: "Ingresa un titulo", label: Text('Titulo')),
          ),
          TextFormField(
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
              widget.add(title, description);
              Navigator.pop(context);
            }
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }

  validateInput(String value) {
    return value.isNotEmpty ? null : "Campo requerido";
  }
}
