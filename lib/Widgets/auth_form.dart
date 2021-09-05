import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//##########################################################################################//
//                                                                                          //
//                             User Authentication Form/Widget.                             //
//                                                                                          //
//##########################################################################################//

class AuthForm extends StatefulWidget {
  final void Function(
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  AuthForm(this.submitFn);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool isLoggingIn = true;
  final _formKey = GlobalKey<FormState>();
  final nameHolder = TextEditingController();
  final passwordHolder = TextEditingController();
  String _userName = '';
  String _userPassword = '';

  void _onSubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userName.trim(),
        _userPassword.trim(),
        isLoggingIn,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.1;
    // double wide = MediaQuery.of(context).size.width;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 2 * size),
                child: Center(
                  child: Image.asset(
                    'images/game-tv-logo.png',
                    height: size,
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
              ),
              SizedBox(
                height: size / 2,
              ),
              Container(
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                    margin: EdgeInsets.all(20),
                    child: registerationForm(),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget registerationForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                usernameField(),
                SizedBox(height: 25),
                passwordField(),
              ],
            ),
          ),
          // SizedBox(height: ),
          loginRegisterButtons(),
        ],
      ),
    );
  }

  Widget usernameField() {
    return TextFormField(
      controller: nameHolder,
      key: ValueKey('username'),
      onSaved: (value) {
        _userName = value.toString();
      },
      validator: (value) {
        if (value!.isEmpty || value.length < 3) {
          return 'Please enter atleast 3 characters!';
        } else if (value.length > 11) {
          return 'Username length must be less than 12 characters!';
        }
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          Icons.person,
          color: Colors.blueAccent[400],
        ),
        hintText: 'Enter Username',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Colors.blueAccent[400] ?? Colors.blue)),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: passwordHolder,
      key: ValueKey('password'),
      onSaved: (value) {
        _userPassword = value.toString();
      },
      validator: (value) {
        if (value!.isEmpty || value.length < 3) {
          return 'Password length must be 3 characters long';
        } else if (value.length > 11) {
          return 'Password length must be less than 12 characters!';
        }
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          Icons.password,
          color: Colors.blueAccent[400],
        ),
        hintText: 'Enter Password',
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Colors.blueAccent[400] ?? Colors.blue)),
      ),
      obscureText: true,
    );
  }

  Widget loginRegisterButtons() {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: ElevatedButton(
                // : Colors.blue,
                style: TextButton.styleFrom(primary: Colors.blueAccent[700]),
                onPressed: () {
                  _onSubmit();
                },
                child: Text(
                  isLoggingIn ? 'Login' : 'Register',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      isLoggingIn = !isLoggingIn;
                      nameHolder.clear();
                      passwordHolder.clear();
                    });
                  },
                  child: Text(
                    isLoggingIn
                        ? 'Create new account'
                        : 'I have already an account',
                    style:
                        TextStyle(color: Colors.blueAccent[700], fontSize: 15),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
