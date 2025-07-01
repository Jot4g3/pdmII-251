import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 23, 70, 172)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const UserDetailsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      User(
        name: "João Gabriel Aguiar de Senna",
        username: "jotage",
        avatarUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fbr.freepik.com%2Ffotos-vetores-gratis%2Flivro-menino%2F2&psig=AOvVaw1ImVnpcAQyX4OQnfPwQ_0s&ust=1751479987526000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCPjAhsahnI4DFQAAAAAdAAAAABAE",
        color: const Color.fromARGB(255, 108, 139, 155),
      ),
      User(
        name: "Ismael Lira Nascimento",
        username: "maelkk",
        avatarUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpt.lovepik.com%2Fimages%2Flittle-boy.html&psig=AOvVaw1ImVnpcAQyX4OQnfPwQ_0s&ust=1751479987526000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCPjAhsahnI4DFQAAAAAdAAAAABAJ",
        color: const Color.fromARGB(255, 42, 85, 107),
      ),
      User(
        name: "Kauã Sousa de Oliveira",
        username: "kkauabr",
        avatarUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpt.dreamstime.com%2Ffoto-de-stock-livro-de-leitura-educado-pequeno-do-menino-image69268328&psig=AOvVaw1ImVnpcAQyX4OQnfPwQ_0s&ust=1751479987526000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCPjAhsahnI4DFQAAAAAdAAAAABAR",
        color: const Color.fromARGB(255, 27, 25, 144),
      ),
      User(
        name: "Gabriel Souza de Alencar",
        username: "bilinhas",
        avatarUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8NaXE9ltfwWhA5xZs38GqGnR3hKG6h1V4Wg&s",
        color: Colors.blueGrey,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                foregroundImage: NetworkImage(user.avatarUrl),
                backgroundColor: user.color.withOpacity(0.2),
              ),
              title: Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('@${user.username}'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onTap: () => Navigator.pushNamed(
                context,
                '/details',
                arguments: user,
              ),
            ),
          );
        },
      ),
    );
  }
}

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('@${user.username}'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: user.color.withOpacity(0.1),
            ),
            child: Center(
              child: Hero(
                tag: user.username,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: user.color.withOpacity(0.3),
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.person_outline, color: user.color),
                    const SizedBox(width: 8),
                    Text(
                      '@${user.username}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'User Profile Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      _buildDetailRow('Member since', '2023', Icons.calendar_today),
                      _buildDetailRow('Last active', 'Today', Icons.timelapse),
                      _buildDetailRow('Status', 'Active', Icons.circle, color: Colors.green),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.grey),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class User {
  final String name;
  final String username;
  final String avatarUrl;
  final Color color;

  User({
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.color,
  });
}