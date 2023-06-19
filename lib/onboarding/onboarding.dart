import 'package:flutter/material.dart';
import 'package:uplink/onboarding/content_model.dart';
import 'package:uplink/features/users/presentation/pages/login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        centerTitle: true,
        title: Image(
          image: Image.asset(
            'images/logo.png',
          ).image,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Image(image: AssetImage(contents[i].image), height: 300),
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: currentIndex == contents.length - 1
                ? const EdgeInsets.only(bottom: 0)
                : const EdgeInsets.only(bottom: 140),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Visibility(
            visible: currentIndex == contents.length - 1 ? true : false,
            child: Container(
              height: 60,
              margin: const EdgeInsets.all(40),
              width: double.infinity,
              child: MaterialButton(
                onPressed: () async {
                  currentIndex == contents.length - 1
                      ? Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()))
                      : () {};
                },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("Empezar"),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.only(
        right: 5,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == index
              ? Theme.of(context).primaryColor
              : Colors.grey),
    );
  }
}
