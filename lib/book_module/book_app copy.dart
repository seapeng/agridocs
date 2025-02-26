import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PaginatedGridView(),
  ));
}

class PaginatedGridView extends StatefulWidget {
  @override
  _PaginatedGridViewState createState() => _PaginatedGridViewState();
}

class _PaginatedGridViewState extends State<PaginatedGridView> {
  List<int> items = List.generate(20, (index) => index); // Initial data
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // Simulate a network delay
    await Future.delayed(Duration(seconds: 2));

    List<int> newItems = List.generate(10, (index) => items.length + index);
    setState(() {
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GridView Pagination")),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text(
                        'Item ${items[index]}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    );
                  },
                ),
                if (isLoading)
                  Positioned(
                    bottom: 20, // Adjust as needed
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
