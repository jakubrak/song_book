import 'package:flutter/material.dart';

import '../authentication.dart';

class LoginPageTemplate extends StatefulWidget {
  final String title;
  final String subtitle;
  final String submitText;
  final List<TextFormField> children;
  final Function onSubmit;

  const LoginPageTemplate(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.submitText,
      required this.onSubmit,
      required this.children});

  @override
  State<LoginPageTemplate> createState() => _LoginPageTemplateState();
}

class _LoginPageTemplateState extends State<LoginPageTemplate> {
  final formKey = GlobalKey<FormState>();
  ValueNotifier<bool> submitButtonDisabled = ValueNotifier<bool>(true);
  bool isLoading = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
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
                        Text(
                          errorMessage,
                          style: const TextStyle(fontSize: 20, color: Colors.red),
                          textAlign: TextAlign.center,
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
                        onPressed: disabled ? null : () async {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await widget.onSubmit();
                            } on AuthenticationException catch (e) {
                              setState(() {
                                isLoading = false;
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
