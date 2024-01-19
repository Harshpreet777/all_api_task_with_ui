import 'package:flutter/material.dart';
import 'package:task/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://s3-alpha-sig.figma.com/img/a668/8081/3809f6b5fdb450ddc6f6b2e21f6fca0d?Expires=1706486400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=H7UzHi74wvxS-MdYwx7GHMJUChOh4el-X4DG~pnEqDbYhPaI9CbP38b84qFyBtaT74E7yyvfyfHB~gVH4fqlFHKoYSHZDVJwYM8f5QdFCIhkBwfwRK7k8DKKkaVdY8dy1Qm34kO1JyKFsaqPAEnJmEeo2hbDSL47pMKbIehczAxta0B8-lqvMw3rRXFvQNt-gwfY9OFcndgvtCfZCj38GVwu13eo034Kq9~UTHCysoaHErm~b6LIpxFg2~YHDLjYnNf-YV2Ul1ETM5B6zm9j99KyNUJDIXt1jh3gYJOhBpElGR0YEDSd-N~ocg1YZKdJYAmlQNPLUWBr8PiDlvsllA__'),
                  fit: BoxFit.cover)),
        ),
        const Positioned(
          bottom: 300,
          left: 117,
          child: Text(
            "Welcome",
            style: TextStyle(
                color: Color(0xff1E232C),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          bottom: 180,
          left: 22,
          right: 22,
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff1E232C))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ),
        ),
        Positioned(
          bottom: 94,
          left: 22,
          right: 22,
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    side: MaterialStatePropertyAll(BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 2))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ));
                },
                child: const Text(
                  'Register',
                  style: TextStyle(color: Color(0xff1E232C), fontSize: 16),
                )),
          ),
        ),
      ]),
    );
  }
}
