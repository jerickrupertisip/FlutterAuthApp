import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: const TextStyle(color: Colors.green),
              ),
            const SizedBox(height: 16.0),
            CustomButton(
              text: 'Send Reset Email',
              onPressed: () async {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                final result = await authService.sendPasswordResetEmail(
                  email: _emailController.text,
                );
                if (result != null) {
                  setState(() {
                    _message = result;
                  });
                } else {
                  setState(() {
                    _message = 'Password reset email sent.';
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
