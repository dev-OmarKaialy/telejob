import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/services/shared_preferences_service.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../widgets/indicators.dart';
import '../widgets/page_view_data.dart';

class TeleJobStartPage extends StatefulWidget {
  const TeleJobStartPage({super.key});

  @override
  State<TeleJobStartPage> createState() => _TeleJobStartPageState();
}

class _TeleJobStartPageState extends State<TeleJobStartPage> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentPage < _data.length - 1) {
        setState(() {
          ++_currentPage;
        });
      }
      _pageViewController.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 800), curve: Curves.easeIn);
    });
  }

  final PageController _pageViewController = PageController();
  int _currentPage = 0;
  final List<Data> _data = [
    Data(
      imageUrl: 'assets/vectors/start.png',
      subTitle:
          'مرحبا، هذا التطبيق سيختصر لنا عمليات البحث التقليدية التي نقوم بها للحصول على خدمات مثل الكهرباء والنجارة والتمديدات الصحية',
    ),
    Data(
      imageUrl: 'assets/vectors/e.png',
      subTitle:
          'جد فني الكهرباء الذي سوف يحل لك أغلب المشاكل التي تحدث في منزلك',
    ),
    Data(
      imageUrl: 'assets/vectors/e_equip.png',
      subTitle:
          'وبالإضافة الى ذلك، يمكنك إيجاد الكثير من المعدات الكهربائية في المتجر الخاص بالتطبيق والحصول عليها يطريقة آمنة وسليمة',
    ),
    Data(
      imageUrl: 'assets/vectors/p.png',
      subTitle: 'يمكنك أيضا البحث عن عمال صحية لتحصل على خدماتهم',
    ),
    Data(
      imageUrl: 'assets/vectors/p_equip.png',
      subTitle: 'وكل ما تحتاجه من المعدات',
    ),
    Data(
      imageUrl: 'assets/vectors/c.png',
      subTitle: 'جد عمال نجارة محترفين',
    ),
    Data(
      imageUrl: 'assets/vectors/c_equip.png',
      subTitle: 'والمعدات التي تحتاجها',
    ),
    Data(
      imageUrl: 'assets/vectors/end.png',
      subTitle:
          'سوف تحصل على كل ذلك بأكبر سرعة ممكنة ومن العامل الأقرب لمنزلك الذي قام مسبقا بإنشاء حساب في هذا التطبيق',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SafeArea(
        child: heightScreen < 200
            ? Container()
            : Stack(
                children: [
                  SizedBox(
                    height: heightScreen * 0.8,
                    child: PageView.builder(
                      controller: _pageViewController,
                      onPageChanged: (currentIndex) {
                        setState(() {
                          _currentPage = currentIndex;
                        });
                      },
                      itemCount: _data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(_data[index].imageUrl),
                              SizedBox(
                                height: index == 0 ? 20 : 40,
                              ),
                              Text(
                                _data[index].subTitle,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.7),
                    child: Indicators(_data, _currentPage),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.9),
                    child: _currentPage != 7
                        ? TextButton(
                            onPressed: () async {
                              SharedPreferencesService.setFirstTime();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                            child: const Text('تخطي الكل'),
                          )
                        : Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                SharedPreferencesService.setFirstTime();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                }));
                              },
                              child: const Text('البدء'),
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
