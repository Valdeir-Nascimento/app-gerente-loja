import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController; 
  int pageSelected = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.green,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white)
          )
        ),
        child: BottomNavigationBar(
          currentIndex: pageSelected,
          onTap: (page) {
            _pageController.animateToPage(page, duration: Duration(microseconds: 500), curve: Curves.ease);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Clientes",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Pedidos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_sharp),
              label: "Produtos",
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            pageSelected = page;
          });
        },
        children: [
          Container(color: Colors.red),
          Container(color: Colors.grey),
          Container(color: Colors.amber),
        ],
      ),
    );
  }
}
