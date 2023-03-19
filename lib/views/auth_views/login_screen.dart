import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/models/profile_model.dart';
import 'package:journal_app/providers/auth_provider.dart';
import 'package:journal_app/providers/firestore_provider.dart';
import 'package:journal_app/providers/note_provider.dart';
import 'package:journal_app/views/auth_views/registration_screen.dart';
import 'package:journal_app/views/auth_views/widgets/widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  InputDecoration inputDecoration(String labeltext) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 2),
      ),
      label: Text(labeltext),
    );
  }

  // sign in function
  onLogin() async {
    if (_formKey.currentState!.validate()) {
      await AuthProvider.loginAuth(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        ref.invalidate(profileFromDatabase);
        ref.invalidate(futureNoteProvider);
      });
    }
  }

  onLoginGoogle() async {
    await AuthProvider.signInWithGoogle().then((user) async {
      if (user != null) {
        final ProfileModel profile = ProfileModel(
          uid: user.uid,
          name: user.displayName!,
          email: user.email!,
          password: user.refreshToken!,
          date: DateTime.now(),
        );
        await FireStoreProvider.addNewUser(profile).then((value) {
          if (value) {
            ref.invalidate(profileFromDatabase);
            ref.invalidate(futureNoteProvider);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                'https://images.unsplash.com/photo-1678625562466-54348d91b750?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3N3x8fGVufDB8fHx8&auto=format&fit=crop&w=700&q=100',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Log In!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 15,
                          ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          _formKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your email!';
                          } else if (!value.contains('@') ||
                              !value.contains('.')) {
                            return 'This is not a valid email';
                          } else {
                            return null;
                          }
                        },
                        controller: _emailController,
                        decoration: inputDecoration('Email')),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: true,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                        _formKey.currentState!.validate();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Passwords can not be empty!';
                        } else if (value.length < 6) {
                          'Password should be at least 6 characters long';
                        } else {
                          return null;
                        }
                        return null;
                      },
                      controller: _passwordController,
                      decoration: inputDecoration('Password'),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                      ),
                      onPressed: onLogin,
                      icon: const Icon(Icons.login_rounded),
                      label: const Text('Log In!'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('Or Continue with'),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: GoogleandMobileSign(
                        onGoogleTap: onLoginGoogle,
                        onPhoneIconTap: () {
                          print('phone sign in triggered!');
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    AlreadyUserChecker(
                      firstString: 'Not an user? ',
                      secondString: 'Register Now!',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
