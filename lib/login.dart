import 'package:flutter/material.dart';
import 'package:order/form_card.dart';
import 'package:order/progress_button.dart';
import 'package:order/elevated_button.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final FocusNode _focusNode1 = new FocusNode();
    bool _isSelfHosted = false;
    bool _autoValidate = false;

    final isOneTimePassword = false;
        //error.contains(OTP_ERROR) || _oneTimePasswordController.text.isNotEmpty;

//    final viewModel = widget.viewModel;
//    if (!viewModel.authState.isInitialized) {
//      return Container();
//    }

    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(''),
//      ),
      body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Image.asset('assets/images/logo.png',
                    width: 100.0, height: 100.0),
              ),
              Form(
                //key: _formKey,
                child: FormCard(
                  children: <Widget>[
                     Column(
                      children: <Widget>[
                        TextFormField(
                          //controller: _emailController,
                          //key: _emailKey,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              labelText: "Имя пользователя"),
                          keyboardType: TextInputType.text,
                          autovalidate: false,
                          validator: (val) =>
                            val.isEmpty || val.trim().isEmpty
                              ? "Пожалуйста введите свою Фамилию Имя"
                              : null,
//                          onFieldSubmitted: (String value) =>
//                              FocusScope.of(context)
//                                  .requestFocus(_focusNode1),
                        ),
                        TextFormField(
                            //controller: _passwordController,
                            //key: _passwordKey,
                            autocorrect: false,
                            autovalidate: _autoValidate,
                            decoration: InputDecoration(
                              labelText: "Пароль"
                          ),
                            validator: (val) =>
                          val.isEmpty || val.trim().isEmpty
                              ? "Пожалуйста введите свой пароль"
                              : null,
//                          obscureText: true,
                          //focusNode: _focusNode1,
                          //onFieldSubmitted: (value) => _submitForm(),
                        ),
//                        _isSelfHosted
////                            ? TextFormField(
////                          //controller: _urlController,
////                          //key: _urlKey,
////                          autocorrect: false,
////                          autovalidate: _autoValidate,
////                          decoration: InputDecoration(
////                              labelText: "url"),
////                          validator: (val) =>
////                          val.isEmpty || val.trim().isEmpty
////                              ? "Введите адрес"
////                              : null,
////                          keyboardType: TextInputType.url,
////                        )
////                            : Container(),
////                        _isSelfHosted
////                            ? TextFormField(
////                          //controller: _secretController,
////                          //key: _secretKey,
////                          autocorrect: false,
////                          decoration: InputDecoration(
////                              labelText: "Секрет"),
////                          obscureText: true,
////                        )
////                            : Container(),
                      ],
                    ),

//                    viewModel.authState.error == null || error.contains(OTP_ERROR)
//                        ? Container()
//                        : Container(
//                      padding: EdgeInsets.only(top: 26.0),
//                      child: Center(
//                        child: Text(
//                          viewModel.authState.error,
//                          style: TextStyle(
//                            color: Colors.red,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                      ),
//                    ),
                    SizedBox(height: 24.0),
                    ProgressButton(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      isLoading: false,
                      label: "Войти",
//                      onPressed: () => _submitForm(),
                    ),
//                    isOneTimePassword
//                        ? Container()
//                        : Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: <Widget>[
//                        _isSelfHosted
//                            ? FlatButton(
//                            onPressed: () =>
//                                setState(() => _isSelfHosted = false),
//                            child: Text("hostedlogin"))
//                            : FlatButton(
//                            onPressed: () =>
//                                setState(() => _isSelfHosted = true),
//                            child: Text("hostedlogin2")),
//                        FlatButton(
////                            onPressed: () => viewModel.onGoogleLoginPressed(
////                                context,
////                                _urlController.text,
////                                _secretController.text),
//                            child: Text("ГуглЛогин")),                    isOneTimePassword
////                        ? Container()
////                        : Row(
////                      mainAxisAlignment: MainAxisAlignment.spaceAround,
////                      children: <Widget>[
////                        _isSelfHosted
////                            ? FlatButton(
////                            onPressed: () =>
////                                setState(() => _isSelfHosted = false),
////                            child: Text("hostedlogin"))
////                            : FlatButton(
////                            onPressed: () =>
////                                setState(() => _isSelfHosted = true),
////                            child: Text("hostedlogin2")),
////                        FlatButton(
//////                            onPressed: () => viewModel.onGoogleLoginPressed(
//////                                context,
//////                                _urlController.text,
//////                                _secretController.text),
////                            child: Text("ГуглЛогин")),
////                      ],
////                    ),
//                      ],
//                    ),
//                    isOneTimePassword && !viewModel.isLoading
//                        ? Padding(
//                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
//                      child: ElevatedButton(
//                        label: "Отмена",
//                        color: Colors.grey,
//                        onPressed: () {
//                          setState(() {
//                            //_oneTimePasswordController.text = '';
//                          });
//                          //viewModel.onCancel2FAPressed();
//                        },
//                      ),
//                    )
//                        : Container(),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
