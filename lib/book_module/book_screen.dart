import 'package:flutter/material.dart';
import 'book_model.dart';
import 'category_model.dart';

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
        _buildBookListView(bookModelList, 175, 325),
        _buildTitleSection("ការចិញ្ចឹមសត្វ"),
        _buildBookListView(bookModelList, 175, 325),
        _buildTitleSection("វារីវប្បកម្ម"),
        _buildBookListView(bookModelList, 175, 325),
        _buildSingleTitle(),
        _buildCategoryGridView(),
      ],
    );
  }

  Widget _buildTitleSection(title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            right: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Keeps the row compact
            children: [
              Text(
                "មើលទាំងអស់",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(width: 3), // Adds spacing between text and icon
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

  Widget _buildSingleTitle() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        "ប្រភេទសៀវភៅ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildBookListView(
      List<BookModel> items, double width, double height) {
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
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 229, 229, 229), // Border color
          width: 1, // Border width
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ), // Set border radius
              child: Image.network(
                item.image, // Replace with your image path
                fit: BoxFit.cover,
                height: double.maxFinite,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 5, bottom: 5, left: 8, right: 8), // Top margin of 20
            child: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Keeps the row compact
                  children: [
                    Icon(
                      Icons.today,
                      size: 12,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "20 មករា 2025",
                      style: TextStyle(fontSize: 12),
                    ),
                    // Adds spacing between text and icon
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Keeps the row compact
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 12,
                    ),
                    SizedBox(width: 3),
                    Text(
                      87.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    // Adds spacing between text and icon
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGridView() {
    return GridView.builder(
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      // padding: EdgeInsets.all(),
      padding: EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        mainAxisSpacing: 10, // Space between rows
        crossAxisSpacing: 10, // Space between columns
        childAspectRatio: 1 / 1,
      ),
      itemCount: categoryModelList.length,
      itemBuilder: (context, index) {
        return _buildGridCategoryItem(categoryModelList[index]);
      },
    );
  }

  Widget _buildGridCategoryItem(CategoryModel item) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: const Color.fromARGB(255, 229, 229, 229), // Border color
          width: 1, // Border width
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ), // Set border radius
              child: Image.network(
                item.image, // Replace with your image path
                fit: BoxFit.cover,
                height: double.maxFinite,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            item.name,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          // Adds spacing between text and icon
        ],
      ),
    );
  }
}
