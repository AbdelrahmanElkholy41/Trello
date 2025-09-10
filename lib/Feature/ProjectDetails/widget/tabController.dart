import 'package:flutter/material.dart';

class TabControllerr extends StatelessWidget {
  const TabControllerr({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              tabs: const [
                Tab(text: 'TO DO'),
                Tab(text: 'IN PROGRESS'),
                Tab(text: 'DONE'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTaskList("Fix landing page", "Ali", Colors.orange),
                _buildTaskList("Set up auth", "Mona", Colors.blue),
                _buildTaskList("Login design finished", "Sarah", Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Widget لبناء قائمة من الكروت
  Widget _buildTaskList(String taskTitle, String user, Color color) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, index) => _buildTaskCard(taskTitle, user, color),
    );
  }

  /// 🔹 Widget للكارت الواحد
  Widget _buildTaskCard(String title, String user, Color tagColor) {
    final statusMap = {
      Colors.orange: "TO DO",
      Colors.blue: "IN PROGRESS",
      Colors.green: "DONE",
    };

    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Assigned to $user",
                      style:
                      const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tagColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusMap[tagColor] ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: tagColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
