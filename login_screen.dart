import 'package:flutter/material.dart'; // import package Material Design

// StatefulWidget: dipakai karena ada state lokal (obscure password, checkbox)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true; // state: toggle sembunyikan/tampilkan password
  bool _ingatSaya = false; // state: checkbox "Ingat saya"

  // controller TextField (UI only, logic submit belum difungsikan)
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose(); // bersihkan controller saat widget dihapus
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka dasar halaman (body, appbar, dll)
    return Scaffold(
      body: SafeArea(
        // SafeArea: hindari notch / status bar menutupi konten
        child: SingleChildScrollView(
          // SingleChildScrollView: agar form bisa discroll saat keyboard muncul
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            // Column: komposisi vertikal, elemen disusun dari atas ke bawah
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // CircleAvatar + Icon: komposisi ikon lingkaran bertema hijau
              Center(
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(
                    Icons.lock,
                    color: Colors.green.shade700,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 16), // SizedBox: spacer/jarak vertikal
              // Text: judul halaman
              const Text(
                'Selamat Datang',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),

              // Text: subjudul/keterangan
              Text(
                'Silakan login untuk melanjutkan',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),

              // Container + BoxDecoration: komposisi "card" berisi form login
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text: label field
                    const Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),

                    // TextField: input email dengan prefix icon
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Masukkan email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Password',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),

                    // TextField: input password dengan toggle show/hide (suffixIcon + IconButton)
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Masukkan password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            // setState: update UI toggle password
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Row: komposisi horizontal untuk checkbox "Ingat saya" & tombol "Lupa Password?"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Row kecil: Checkbox + Text disusun sejajar
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: _ingatSaya,
                              activeColor: Colors.green,
                              onChanged: (val) {
                                setState(() => _ingatSaya = val ?? false);
                              },
                            ),
                            const Text('Ingat saya'),
                          ],
                        ),
                        // TextButton: aksi teks "Lupa Password?"
                        TextButton(
                          onPressed: () {}, // UI only, belum difungsikan
                          child: const Text('Lupa Password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // ElevatedButton: tombol utama LOGIN, full width (stretch dari Column induk)
                    ElevatedButton(
                      onPressed: () {}, // UI only
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('LOGIN'),
                    ),
                    const SizedBox(height: 16),

                    // Row + Expanded + Divider: komposisi garis pemisah dengan teks "atau" di tengah
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'atau',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // OutlinedButton: tombol sekunder navigasi ke halaman Registrasi
                    OutlinedButton(
                      onPressed: () {
                        // Navigator.pushNamed: pindah ke route '/register'
                        Navigator.pushNamed(context, '/register');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green.shade700,
                        side: BorderSide(color: Colors.green.shade300),
                        minimumSize: const Size.fromHeight(48),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('BUAT AKUN BARU'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Text: footer copyright
              Center(
                child: Text(
                  '© 2026 Afrizal',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
