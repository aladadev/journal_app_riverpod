import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/models/profile_model.dart';
import 'package:journal_app/providers/auth_provider.dart';
import 'package:journal_app/providers/firestore_provider.dart';
import 'package:journal_app/views/auth_views/widgets/widgets.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // obscure password mode
  bool hidePassword = true;

  bool hideConfirmPassword = true;
  // TextField Decoration Helper Method
  InputDecoration inputDecoration(String labeltext) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderSide: BorderSide(width: 2),
      ),
      label: Text(labeltext),
    );
  }

  //On Register Button Method
  _onRegister() async {
    if (_formkey.currentState!.validate()) {
      await AuthProvider.registerAuth(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        confirmpass: _confirmPasswordController.text.trim(),
      ).then((user) async {
        if (user != null) {
          final ProfileModel profile = ProfileModel(
            uid: user.uid,
            name: _nameController.text.trim(),
            email: user.email.toString(),
            password: _passwordController.text.trim(),
            date: DateTime.now(),
          );
          await FireStoreProvider.addNewUser(profile).then((value) {
            if (value) {
              ref.invalidate(profileFromDatabase);
              Navigator.pop(context);
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
            // Positioned.fill(
            //   child: Image.network(
            //     'https://images.unsplash.com/photo-1497250681960-ef046c08a56e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cGxhbnR8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=100',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1497250681960-ef046c08a56e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cGxhbnR8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=100'),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Welcome to \nYour Own Journal App',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 20,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Sign Up!',
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
                          _formkey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Your Name!';
                          } else {
                            return null;
                          }
                        },
                        controller: _nameController,
                        decoration: inputDecoration('Name'),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            _formkey.currentState!.validate();
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
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          _formkey.currentState!.validate();
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
                        obscureText: hidePassword,
                        controller: _passwordController,
                        decoration: inputDecoration('Password').copyWith(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          _formkey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Passwords can not be empty!';
                          } else if (value.length < 6) {
                            'Password should be at least 6 characters long';
                          } else if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            return 'Your passwords do not match';
                          } else {
                            return null;
                          }
                          return null;
                        },
                        obscureText: hideConfirmPassword,
                        controller: _confirmPasswordController,
                        decoration:
                            inputDecoration('Confirm Password').copyWith(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hideConfirmPassword = !hideConfirmPassword;
                              });
                            },
                            icon: const Icon(
                              Icons.remove_red_eye,
                            ),
                          ),
                        ),
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
                        onPressed: _onRegister,
                        icon: const Icon(Icons.login_rounded),
                        label: const Text('Register'),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      AlreadyUserChecker(
                        firstString: 'Already an user? ',
                        secondString: 'Log In!',
                        onPress: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
