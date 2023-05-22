import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:weather/models/boxes.dart';
import '../models/pengguna.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // validated() {
  //   if (_formKey.currentState != null && _formKey.currentState.validate()) {
  //     _onFormSubmit();
  //     print("Form Validated");
  //   } else {
  //     print("Form not validated");
  //     return;
  //   }
  // }

  String username;
  String password;

  // void _onFormSubmit() {
  //   Box<Pengguna> penggunaBox = Hive.box<Pengguna>(HiveBoxex.pengguna);
  //   penggunaBox.add(Pengguna(username: username, password: password));
  //   Navigator.of(context).pop();
  //   print(penggunaBox);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Column(
            children: [
              Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Lengkapi Data Anda Untuk Mendaftar!",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              SafeArea(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'username',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          validator: (String value) {
                            if (value == null || value.trim().length == 0) {
                              return "Required";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            username = value;
                          },
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: 'password',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          obscureText: true,
                          validator: (String value) {
                            if (value == null || value.trim().length == 0) {
                              return "Required";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        SizedBox(height: 24),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[400],
                              onPrimary: Colors.white,
                            ),
                            onPressed: () {
                              register(username, password);
                            },
                            child: Text('Buat Akun')),
                        SizedBox(height: 24),
                        // _buildButtonSubmit(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register(String username, String password) async {
    final encryptedPassword = encryptPassword(password);

    final box = await Hive.openBox<Pengguna>(HiveBoxex.pengguna);
    final existingUser = box.values.firstWhere(
      (user) => user.username == username,
      orElse: () => null,
    );

    if (existingUser == null &&
        _formKey.currentState != null &&
        _formKey.currentState.validate()) {
      final newUser = Pengguna(username: username, password: encryptedPassword);
      await box.add(newUser);
      print(newUser);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registrasi Berhasil'),
          content: Text('Pengguna berhasil didaftarkan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registrasi Gagal'),
          content: Text('Username sudah digunakan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String encryptPassword(String password) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;
  }
}
