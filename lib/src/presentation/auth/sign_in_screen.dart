import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/auth_providers.dart';
import '../../core/errors/app_exception.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInEmail() async {
    setState(() => loading = true);
    try {
      await ref.read(authRepositoryProvider).signInWithEmail(
            emailController.text.trim(),
            passwordController.text.trim(),
          );
      if (!mounted) return;
      context.go('/home');
    } on AppException catch (e) {
      _showError(e.message);
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _signInGoogle() async {
    setState(() => loading = true);
    try {
      await ref.read(authRepositoryProvider).signInWithGoogle();
      if (!mounted) return;
      context.go('/home');
    } on AppException catch (e) {
      _showError(e.message);
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: loading ? null : _signInEmail,
                  child: loading ? const CircularProgressIndicator() : const Text('Sign in'),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Sign in with Google'),
                onPressed: loading ? null : _signInGoogle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

