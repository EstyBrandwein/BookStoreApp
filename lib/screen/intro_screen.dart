import 'package:flutter/material.dart';
import 'package:new_/screen/Home_Screen.dart';
import '../Model/model.dart';

class IntroScreen extends StatelessWidget {
  final VoidCallback toggleDarkMode;
  final bool isDarkMode;
  IntroScreen({required this.isDarkMode, required this.toggleDarkMode});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("welcom"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: toggleDarkMode,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Welcom To our books store",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return GridTile(
                        child: Image.asset(book.imageURL, fit: BoxFit.cover),
                        footer: GridTileBar(
                          backgroundColor: Colors.black54,
                          title: Text(
                            book.title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    })),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                        toggleDarkMode: toggleDarkMode, isDarkMode: isDarkMode),
                  ),
                );
              },
              child: Text("היכנס עמוד הבית"),
            ),
          ],
        ),
      ),
    );
  }
}
