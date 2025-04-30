import 'package:top_back/bean/bean_user.dart';
import 'package:top_back/constants/app_constants.dart';
import 'package:top_back/constants/app_storage.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/router/router.dart';
import 'package:top_back/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController inputA = TextEditingController();
  TextEditingController inputP = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    inputA.dispose();
    inputP.dispose();
  }

  Future<void> onTapLogin() async {
    bool validate = formKey.currentState?.validate() ?? false;
    if (!validate) return;

    Toast.showLoading();

    String password = AppConstants.encryptPassword(inputP.text);
    var response = await DioRequest().request(
      HttpConstant.login,
      method: DioMethod.POST,
      data: {"userId": inputA.text, "password": password},
    );

    Toast.dismissLoading();
    onLoginSuccess(response);
  }

  void onLoginSuccess(response) {
    if (response == null) return;
    Storage().user = BeanUser.fromJson(response);
    Storage().saveUserToStorage();
    context.go(RouterPath.path_dashboard);
  }

  Widget buildLoginContent() {
    return Form(
      key: formKey,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 10),
        InputLogin(InputLoginType.ACCOUNT, inputA),
        const SizedBox(height: 30),
        InputLogin(InputLoginType.PASSWORD, inputP),
        const SizedBox(height: 20),
        buildLoginButton(),
      ]),
    );
  }

  Widget buildLoginButton() {
    return ElevatedButton(
      onPressed: onTapLogin,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        fixedSize: Size.fromWidth(260),
      ),
      child: Text("登录"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          width: 280,
          child: buildLoginContent(),
        ),
      )),
    );
  }
}

enum InputLoginType { ACCOUNT, PASSWORD }

extension InputLoginTypeExtension on InputLoginType {
  String get hintText => ["请输入账号", "请输入密码"][index];

  IconData get icon =>
      [Icons.supervisor_account, Icons.lock_outline_sharp][index];
}

class InputLogin extends StatelessWidget {
  InputLogin(this.type, this.input, {super.key});

  final InputLoginType type;

  final TextEditingController input;

  String? onInputValidator(String? string) {
    if (string == null || string.isEmpty) return type.hintText;
    return null;
  }

  final enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Color(0xFFCECECE), width: 1),
  );

  final focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.blue, width: 1),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.redAccent, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: onInputValidator,
      controller: input,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(type.icon),
        constraints: const BoxConstraints(minHeight: 25),
        enabledBorder: enableBorder,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
