import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/pages/controllerPage/controllerPage.dart';
import 'package:movies/utils/components/loginBotao_item.dart';
import 'package:movies/utils/constants.dart';
import 'package:movies/utils/customSharedPreferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              pageOne(),
              pageTwo(),
              pageThree(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: WormEffect(
                  activeDotColor: SALMON,
                  dotColor: SALMON.withOpacity(0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container pageOne() {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: BLUE,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 15, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OnBoardingButton(
                  pageController: _pageController,
                  text: "Próximo",
                  icon: Icons.arrow_forward_ios,
                  onTap: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.15),
          Container(
            height: height * 0.3,
            child: Image(
              image: AssetImage('lib/utils/assets/images/one.png'),
            ),
          ),
          SizedBox(height: height * 0.1),
          Text(
            "Um app de filmes.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Container pageTwo() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: BLUE,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 15, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OnBoardingButton(
                  pageController: _pageController,
                  text: "Voltar",
                  icon: Icons.arrow_back_ios,
                  onTap: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
                ),
                SizedBox(width: width * 0.53),
                OnBoardingButton(
                  pageController: _pageController,
                  text: "Próximo",
                  icon: Icons.arrow_forward_ios,
                  onTap: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.15),
          Container(
            height: height * 0.3,
            child: Image(
              image: AssetImage('lib/utils/assets/images/two.png'),
            ),
          ),
          SizedBox(height: height * 0.1),
          Text(
            "Cadastre sua biometria.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Container pageThree() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: BLUE,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 15, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OnBoardingButton(
                  pageController: _pageController,
                  text: "Voltar",
                  icon: Icons.arrow_back_ios,
                  onTap: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
                ),
                SizedBox(width: width * 0.45),
                OnBoardingButton(
                  pageController: _pageController,
                  text: "Ir para a Home",
                  icon: Icons.arrow_forward_ios,
                  onTap: () async {
                    await CustomSharedPreferences.saveUsuarioOnBoarding(true);
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(
                          builder: (context) => ControllerPage(),
                        ),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.15),
          Container(
            height: height * 0.3,
            child: Image(
              image: AssetImage('lib/utils/assets/images/three.png'),
            ),
          ),
          SizedBox(height: height * 0.1),
          Text(
            "Salve seus favoritos.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class OnBoardingButton extends StatelessWidget {
  final PageController pageController;
  final Function onTap;
  final String text;
  final IconData icon;
  const OnBoardingButton({
    Key key,
    this.pageController,
    this.onTap,
    this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: text == "Voltar"
            ? Row(
                children: [
                  Icon(
                    icon,
                    color: SALMON,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    text,
                    style: TextStyle(color: SALMON.withOpacity(0.6)),
                  ),
                ],
              )
            : Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(color: SALMON.withOpacity(0.6)),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Icon(
                    icon,
                    color: SALMON,
                  ),
                ],
              ),
      ),
    );
  }
}
