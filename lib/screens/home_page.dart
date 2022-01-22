import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_demo/screens/login_page.dart';
import 'package:flutterfire_demo/utils/authentication_client.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authClient = AuthenticationClient();

  bool _isProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Authenticated User\n\nUID: ${widget.user.uid}\nName: ${widget.user.displayName}\nEmail: ${widget.user.email}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 24.0),
            _isProgress
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isProgress = true;
                        });
                        await _authClient.logoutUser();
                        setState(() {
                          _isProgress = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(fontSize: 22.0),
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
