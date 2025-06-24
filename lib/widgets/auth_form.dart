import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final String buttonText;

  const AuthForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onSubmit, child: Text(buttonText)),
      ],
    );
  }
}
