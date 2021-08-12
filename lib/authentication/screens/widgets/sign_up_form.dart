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

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _onSignUpButtonPressed(BuildContext context) async {
    final email = _emailController.text.toLowerCase().trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty) {
      showAlert(message: 'Please enter your email', context: context);
      return;
    }

    bool isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (!isEmailValid) {
      showAlert(
        message: 'Please enter a valid email',
        context: context,
      );
      return;
    }

    if (password.isEmpty) {
      showAlert(
        message: 'Please enter your password',
        context: context,
      );
      return;
    }

    if (password != confirmPassword) {
      showAlert(
        message: 'Make sure your password and the confirm password match',
        context: context,
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();

    authProvider.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
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
            onPress: () => _onSignUpButtonPressed(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> showAlert(
      {required String message, required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
