import 'package:eighty_two/authentication/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_button.dart';
import 'auth_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? passwordError;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            labelText: "Email",
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            textEditingController: _emailController,
            textInputAction: TextInputAction.next,
            focusNode: _emailNode,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _emailNode, _passwordNode);
            },
          ),
          const SizedBox(height: 10),
          AuthTextField(
            labelText: "Pasword",
            duration: Duration(milliseconds: 400),
            obscureText: true,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            textEditingController: _passwordController,
            textInputAction: TextInputAction.next,
            focusNode: _passwordNode,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _passwordNode, _confirmPasswordNode);
            },
          ),
          const SizedBox(height: 10),
          AuthTextField(
            labelText: "Confirm Pasword",
            duration: Duration(milliseconds: 500),
            obscureText: true,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            textEditingController: _confirmPasswordController,
            textInputAction: TextInputAction.done,
            focusNode: _confirmPasswordNode,
          ),
          const SizedBox(height: 10),
          AuthButton(
            duration: const Duration(milliseconds: 600),
            text: 'Sign Up',
            onPress: () {
              if (_passwordController.text.trim().isEmpty) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => AlertDialog(
                    content: const Text('Enter your password!'),
                  ),
                );
                return;
              }
              if (_passwordController.text != _confirmPasswordController.text) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (_) => AlertDialog(
                    content:
                        const Text('Ensure your password and confirm password match'),
                  ),
                );
                return;
              }
              context.read<AuthProvider>().signUpWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
