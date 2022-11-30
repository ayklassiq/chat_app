import 'dart:io';

import 'package:chat_app/widgets/picker/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
AuthForm(this.submitFn,this.isLoading);
bool isLoading;
final void Function(
    String email,
    String password,
     String userName,
    File image,
    bool isLogin,
    ) submitFn;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
var _isLogin =true;
var _userEmail = '';
  var  _userName = '';
  var  _userPassword = '';
  File? _userImageFile;

  void   _pickedImage(File image){
    _userImageFile =image;
  }
  void _trySubmit() {
    final  isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile ==null && !_isLogin){
       // Scaffold.of(context).showSnackBar(
      //   const SnackBar(content: Text('Pleasse pick an Image'),),
      // ),
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile! ,
        _isLogin,
      );
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(!_isLogin)
                UserImagePicker(_pickedImage),
              TextFormField(
                key: const ValueKey('email'),
                validator: (value) {
                  if (value == null || value.isEmpty|| !value.contains('@')) {
                    return 'please enter a a valid email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration:  const InputDecoration(labelText: 'Email Address'),
                onSaved: (value){
                  _userEmail =value!;
                },
              ),
              if(!_isLogin)
              TextFormField(
                key: const ValueKey('username'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 4) {
                    return 'Please enter at least & characters';
                  }
                  return null;
                },
                decoration:  const InputDecoration(labelText: 'Username'),
                onSaved: (value){
                  _userName =value!;
                },
              ),
              TextFormField(
                key: const ValueKey('password'),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 7) {
                    return 'Please enter at least & characters';
                  }
                  return null;
                },
                decoration:  const InputDecoration(
                  labelText: ' Password',
                ),
                obscureText: true,
                onSaved: (value){
                  _userPassword =value!;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              if(widget.isLoading)const CircularProgressIndicator(),
              if(!widget.isLoading)
              ElevatedButton(
                onPressed: _trySubmit,
                child:  Text(_isLogin ? 'Login': 'Signup'),
              ),
              if(!widget.isLoading)
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _isLogin =!_isLogin;
                  });
                },
                child: Text(_isLogin ? 'Create new account':'I already have an account'),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
