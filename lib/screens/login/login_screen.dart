import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/hive/boxes.dart';
import 'package:weather/models/hive/pengguna.dart';
import 'package:weather/screens/homepage/loading_screen.dart';
import 'package:weather/screens/login/registrasi_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  bool isLoginSuccess = true;
  var passwordVisible = false;
  SharedPreferences logindata;

  @override
  void initState() {
    super.initState();
    checkIsLogin();
  }

  void checkIsLogin() async {
    logindata = await SharedPreferences.getInstance();
    bool isLogin = (logindata.getString('username') != null) ? true : false;
    if (isLogin && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoadingPage()),
          (route) => false);
    }
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _logo(),
            _username(),
            _password(),
            _loginbutton(context),
            _register(context),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 50),
        child: Image.asset(
          "assets/icons/logo.png",
          width: 100,
        ),
      ),
    );
  }

  Widget _username() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        controller: username_controller,
        enabled: true,
        style: TextStyle(color: Colors.white),
        // onChanged: (value) {
        //   username = value;
        // },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            hintText: "username",
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            labelText: "username",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.blue[400]),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: (isLoginSuccess) ? Colors.blue[400] : Colors.red),
            )),
      ),
    );
  }

  Widget _password() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        controller: password_controller,
        enabled: true,
        obscureText: !passwordVisible,
        style: TextStyle(color: Colors.white),
        // onChanged: (value) {
        //   password = value;
        // },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_rounded, color: Colors.white),
          hintText: "password",
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "password",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Color(0xFFFCA311)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
                color: (isLoginSuccess) ? Colors.blue[400] : Colors.red),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              // Menyesuaikan ikon berdasarkan status visibilitas teks password
              passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _loginbutton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: (isLoginSuccess) ? Colors.blue[400] : Colors.red,
          onPrimary: Colors.white,
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          String username = username_controller.text;
          String password = password_controller.text;
          String text = "";

          if (username.isNotEmpty && password.isNotEmpty) {
            final encrypter =
                encrypt.Encrypter(encrypt.AES(encrypt.Key.fromLength(32)));
            final encryptedPassword =
                encrypter.encrypt(password, iv: encrypt.IV.fromLength(16));

            var box = await Hive.openBox<Pengguna>(HiveBoxex.pengguna);
            for (int index = 0; index < box.values.length; index++) {
              Pengguna res = box.getAt(index);
              print(res);

              if (res.password == encryptedPassword.base64 &&
                  res.username == username) {
                logindata.setString('username', username);
                if (mounted) {
                  setState(() {
                    text = "Login Berhasil";
                    isLoginSuccess = true;
                  });
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoadingPage()),
                    (route) => false,
                  );
                }
              } else {
                setState(() {
                  text = "Login Gagal";
                  isLoginSuccess = false;
                });
              }
            }
          } else {
            setState(() {
              text = "Isi username dan password";
              isLoginSuccess = false;
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _register(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RegisterPage();
          }));
        },
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
