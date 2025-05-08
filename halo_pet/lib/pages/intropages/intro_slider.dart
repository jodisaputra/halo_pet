import 'package:flutter/material.dart';
import 'package:halo_pet/pages/login_pages/login_page.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': 'lib/assets/image/logo_transparant_2.png',
      'title': 'HaloPet',
      'subtitle': 'Your Pet\'s Best Friend',
    },
    {
      'image': 'lib/assets/image/intro_page_2.png',
      'title': 'Dokter Terbaik',
      'subtitle': 'Dapatkan akses dokter terbaik secara instan dan anda dapat dengan mudah menghubungi dokter untuk kebutuhan anda',
    },
    {
      'image': 'lib/assets/image/intro_page_3.png',
      'title': 'Informasi Tepat dan Cepat',
      'subtitle': 'Memberikan anda tentang kesehatan hewan peliharan anda secara instan dan mudah dimanapun anda berapa',
    },
    {
      'image': 'lib/assets/image/intro_page_4.png',
      'title': 'Dapatkan obat secara cepat',
      'subtitle': 'Dapatkan obat dan rekomendasi dokter untuk hewan peliharaanmu dimana pun anda berada',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  void _skipToLast() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      _pages[index]['image']!,
                      height: index == 0 ? 170 : 400,
                    ),
                    const SizedBox(height: 30),
                    if (index == 0)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Halo",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                            ),
                          ),
                          Text(
                            "Pet",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        _pages[index]['title']!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (index > 0)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          _pages[index]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: _skipToLast,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _nextPage,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 