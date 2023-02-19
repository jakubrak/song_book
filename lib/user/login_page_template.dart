import 'package:flutter/material.dart';

import '../authentication.dart';

class LoginPageTemplate extends StatefulWidget {
  final String title;
  final String subtitle;
  final String submitText;
  final Function onSubmit;
  final Function onSubmitDone;
  final List<TextFormField> children;

  const LoginPageTemplate(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.submitText,
      required this.onSubmit,
      required this.onSubmitDone,
      required this.children});

  @override
  State<LoginPageTemplate> createState() => _LoginPageTemplateState();
}

enum Status { init, loading, done, error }

class _LoginPageTemplateState extends State<LoginPageTemplate> {
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> submitButtonDisabled = ValueNotifier<bool>(true);
  Status status = Status.init;
  String errorMessage = "";

  Widget buildProgressIndicator() {
    if (status == Status.done) {
      return const Icon(
        Icons.done,
        size: 52,
      );
    }

    if (status == Status.error) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.error,
            size: 52,
          ),
          Text(errorMessage)
        ],
      );
    }

    return const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return status != Status.init
        ? Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                toolbarHeight: 40.0,
                toolbarOpacity: 1.0,
                automaticallyImplyLeading: false,
                leading: status == Status.error
                    ? TextButton.icon(
                        onPressed: () {
                          setState(() {
                            status = Status.init;
                          });
                        },
                        icon: const Icon(Icons.close, size: 30),
                        label: const Text(""),
                      )
                    : null),
            body: Center(
              child: buildProgressIndicator(),
            ))
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                toolbarHeight: 40.0,
                toolbarOpacity: 1.0,
                automaticallyImplyLeading: false,
                leading: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 30),
                  label: const Text(""),
                )),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: formKey,
                  onChanged: () {
                    submitButtonDisabled.value =
                        !formKey.currentState!.validate() ||
                            widget.children.any((textFormField) =>
                                textFormField.controller!.text.isEmpty);
                  },
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.subtitle,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                            children: List<Container>.from(
                                widget.children.map((form) => Container(
                                      height: 65.0,
                                      child: form,
                                    ))))
                      ])),
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ValueListenableBuilder<bool>(
                    valueListenable: submitButtonDisabled,
                    builder: (context, disabled, child) {
                      return MaterialButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor: Theme.of(context).primaryColorLight,
                        shape: const BeveledRectangleBorder(),
                        padding: const EdgeInsets.all(16.0),
                        onPressed: disabled
                            ? null
                            : () async {
                                setState(() {
                                  status = Status.loading;
                                });
                                try {
                                  await widget.onSubmit();
                                  setState(() {
                                    status = Status.done;
                                  });
                                  await widget.onSubmitDone();
                                } on AuthenticationException catch (e) {
                                  setState(() {
                                    status = Status.error;
                                    errorMessage = e.message;
                                  });
                                }
                              },
                        child: Text(
                          widget.submitText,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    })));
  }
}
