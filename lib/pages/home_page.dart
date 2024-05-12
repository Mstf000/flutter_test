import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:chat_app/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  String getUsername() {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? '';
    return email.split('@').first;
  }

  void _showStartSessionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Prepare for Your Session'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please make sure that the python code is running...'),
              const SizedBox(height: 20),
              const Text('Wear Your AR Headset'),
              Image.asset('images/gif2.gif'), // Displaying the GIF
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('START'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final username = getUsername();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('BraveSpeakAR', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Welcome, $username", style: TextStyle(fontSize: 24)),
              accountEmail: Text(FirebaseAuth.instance.currentUser?.email ?? ''),
              // currentAccountPicture: CircleAvatar(
              //   child: const Icon(Icons.face, size: 40.0),
              //   backgroundColor: Colors.white,
              // ),
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Account Settings'),
              onTap: () {
                // Handle Settings Navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Options'),
              onTap: () {
                // Handle Options Navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () => signUserOut(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _MetricCard(title: 'Voice Stuttering', value: 'uhmm', icon: Icons.record_voice_over),
                  _MetricCard(title: 'Profiled Movement', value: 'Crossed Hands', icon: Icons.directions_walk),
                  _MetricCard(title: 'Emotion Analysis', value: 'Mostly Neutral', icon: Icons.emoji_emotions),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text('Social Phobia Progress', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      const Text('Last 5 Sessions', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 180,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(show: false),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 16),
                                  FlSpot(1, 9.5),
                                  FlSpot(2, 6),
                                  FlSpot(3, 4),
                                  FlSpot(4, 2.5),
                                ],
                                isCurved: true,
                                barWidth: 2,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: ListTile(
                  title: const Text('Taken Sessions', style: TextStyle(fontSize: 20)),
                  trailing: const Text('9', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Use 'backgroundColor' instead of 'primary'
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8) // Optional: if you want rounded corners
                    ),
                    textStyle: TextStyle(
                      fontSize: 18, // Font size for text inside the button
                    )
                ),
                onPressed: () => _showStartSessionDialog(context),
                child: Text('START YOUR SESSION'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _MetricCard({Key? key, required this.title, required this.value, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 40, color: Theme.of(context).colorScheme.secondary),
              const SizedBox(height: 10),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
