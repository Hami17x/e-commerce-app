import 'package:amazon_clone/common/widgets/custom_botton.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/service/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { sigin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  void signupUser() {
    authService.signUpUser(
        email: _emailController.text,
        context: context,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
        email: _emailController.text,
        context: context,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Welcome"),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: Text("Create Account"),
                leading: Radio(
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
              ),
              if (_auth == Auth.signup)
                Container(
                  color: GlobalVariables.backgroundColor,
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextfield(
                            controller: _nameController,
                            hintText: "Name",
                          ),
                          CustomTextfield(
                            controller: _emailController,
                            hintText: "Email",
                          ),
                          CustomTextfield(
                            controller: _passwordController,
                            hintText: "Password",
                          ),
                          CustomButton(
                              onPressed: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signupUser();
                                }
                              },
                              text: "SignUp")
                        ],
                      )),
                ),
              ListTile(
                tileColor: _auth == Auth.sigin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: Text("Sigin"),
                leading: Radio(
                    value: Auth.sigin,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
              ),
              if (_auth == Auth.sigin)
                Container(
                  color: GlobalVariables.backgroundColor,
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextfield(
                            controller: _emailController,
                            hintText: "Email",
                          ),
                          CustomTextfield(
                            controller: _passwordController,
                            hintText: "Password",
                          ),
                          CustomButton(
                              onPressed: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  signInUser();
                                }
                              },
                              text: "SignIn")
                        ],
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
