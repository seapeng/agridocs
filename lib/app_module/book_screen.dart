import 'package:agridocs/app_module/book_model.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          debugPrint("Hello WOrld");
        },
        child: Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: _buildLeadingLogo(),
      title: const Text(
        'បណ្ណាល័យកសិកម្ម',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            debugPrint('Search');
          },
        ),
      ],
    );
  }

  Widget _buildLeadingLogo() {
    return Container(
      padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: (Image.asset('assets/images/logo.png')),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: 'ឯកសារ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.smart_display),
          label: 'វីដេអូ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'បន្ថែម',
        ),
      ],
    );
  }

  Widget _buildBody() {
    return _buildListView();
  }

  Widget _buildListView() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        _buildTitleSection("ការដាំដំណាំ"),
        _buildBookListView(BookModelList, 250, 150),
        _buildTitleSection("ការចិញ្ចឹមសត្វ"),
        _buildBookListView(BookModelList, 250, 150),
        _buildTitleSection("វារីវប្បកម្ម"),
        _buildBookListView(BookModelList, 250, 150),
      ],
    );
  }

  Widget _buildTitleSection(title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Keeps the row compact
            children: [
              Text(
                "មើលទាំងអស់",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 5), // Adds spacing between text and icon
              Icon(
                Icons.arrow_forward,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookListView(
      List<BookModel> items, double height, double width) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildBookItem(items[index], width);
        },
      ),
    );
  }

  Widget _buildBookItem(BookModel item, width) {
    return Container(
        width: width,
        margin: EdgeInsets.only(right: 10),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                item.image,
                fit: BoxFit.cover,
                height: double.maxFinite,
              ),
            ),
            Text(
              item.title,
              maxLines: 1,
            )
          ],
        ));
  }
}
