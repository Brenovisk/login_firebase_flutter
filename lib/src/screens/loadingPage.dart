import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase_flutter_test/src/components/waveWidget.dart';
import 'package:login_firebase_flutter_test/src/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLogin = true;
  bool loading = false;
  bool showPassword = false;
  bool isTransition = false;

  late String title;
  late String actionButtonText;
  late String toggleButtonText;

  setFormAction(bool action) {
    setState(() {
      isTransition = !isTransition;
      isLogin = action;

      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          isTransition = false;
          if (isLogin) {
            title = 'Bem vindo ';
            actionButtonText = 'Login';
            toggleButtonText = 'Ainda não tem conta? Cadastre-se agora.';
          } else {
            title = 'Crie sua Conta';
            actionButtonText = 'Cadastrar';
            toggleButtonText = 'Voltar ao login';
          }
        });
      });
    });
  }

  login() async {
    print("Login");
    setState(() => loading = true);
    try {
      print("Login");
      await context.read<AuthService>().loginUser(email.text, password.text);
    } on AuthException catch (e) {
      setState(() => loading = false);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  register() async {
    print("Register");
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registerUser(email.text, password.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  handleButton() {
    if (formKey.currentState!.validate()) {
      isLogin ? login() : register();
    }
  }

  validator(value, String field) {
    if (value!.isEmpty) {
      return 'Informe sua senha!';
    } else if (value.length < 6 && field == 'pwd') {
      return 'Sua senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    title = 'Bem vindo ';
    actionButtonText = 'Login';
    toggleButtonText = 'Ainda não tem conta? Cadastre-se agora.';
    isLogin = true;
    // setFormAction(true);
  }

  //Renders

  List<Widget> renderTextButton() => [
        const Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(color: Colors.white),
          ),
        )
      ];

  List<Widget> renderLoading() => [
        const Icon(Icons.check),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            actionButtonText,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        )
      ];

  Widget renderButton() => Padding(
        padding: EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: handleButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: !loading ? renderLoading() : renderTextButton(),
          ),
        ),
      );

  Widget renderShowPwdIcon() => IconButton(
        icon: Icon(showPassword
            ? CupertinoIcons.eye_solid
            : CupertinoIcons.eye_slash_fill),
        onPressed: () => setState(() => showPassword = !showPassword),
      );

  Widget renderTitleSection() => Text(
        title,
        style: const TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.5,
        ),
      );

  InputDecoration renderInputDecoration(String label, isPwd) => InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        suffixIcon: isPwd
            ? Padding(
                padding: const EdgeInsetsDirectional.only(end: 8.0),
                child: renderShowPwdIcon(),
              )
            : const SizedBox(width: 0, height: 0),
      );

  Widget renderInputEmail() => Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 64),
        child: TextFormField(
            controller: email,
            decoration: renderInputDecoration('Email', false),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => validator(value, 'email')),
      );

  Widget renderInputPwd() => Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 0),
        child: TextFormField(
            controller: password,
            obscureText: !showPassword,
            decoration: renderInputDecoration('Senha', true),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => validator(value, 'pwd')),
      );

  Widget renderToggleButtonText() => TextButton(
        onPressed: () => setFormAction(!isLogin),
        child: Text(toggleButtonText),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    movePaddingForm() {
      if (isTransition && keyboardOpen) {
        return size.height * 0.6;
      } else if (isTransition) {
        return size.height;
      } else {
        return size.height * (keyboardOpen ? 0.1 : 0.4);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height - 200,
              color: Colors.lightBlue,
            ),
            SizedBox(
              height: size.height * 0.5,
              child: SvgPicture.asset(
                "lib/src/assets/Logo.svg",
                matchTextDirection: false,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutQuad,
              top: keyboardOpen ? -size.height / 3.7 : 0.0,
              child: WaveWidget(
                size: size * 2,
                yOffset: size.height / 3.0,
                color: Colors.white,
              ),
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              padding: EdgeInsets.only(top: movePaddingForm()),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    renderTitleSection(),
                    renderInputEmail(),
                    renderInputPwd(),
                    renderButton(),
                    renderToggleButtonText()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
