import 'package:flutter/material.dart'; // import package Material Design

// StatefulWidget: banyak state (radio, dropdown, slider, switch, checkbox, obscure password)
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true; // state: toggle password
  String _jenisKelamin = 'Laki-laki'; // state: pilihan radio button
  String? _pendidikan; // state: pilihan dropdown
  double _pengalaman = 0; // state: nilai slider (0 = Pemula .. 100 = Ahli)
  bool _notifikasi = true; // state: switch notifikasi
  bool _setujuSyarat = true; // state: checkbox syarat & ketentuan

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  final List<String> _daftarPendidikan = [
    'SD',
    'SMP',
    'SMA/SMK',
    'Diploma',
    'S1',
    'S2',
    'S3',
  ]; // List<String>: data sumber DropdownButton

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: kerangka dasar halaman
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // SingleChildScrollView: agar seluruh form panjang bisa discroll
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            // Column: komposisi vertikal utama halaman
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // CircleAvatar + Icon: header ikon tema hijau
              Center(
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.green.shade100,
                  child: Icon(
                    Icons.person_add_alt_1,
                    color: Colors.green.shade700,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Buat Akun Baru',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Silakan lengkapi data untuk membuat akun',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),

              // Container 1: card berisi data akun (nama, email, password)
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Lengkap',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    // TextField: input nama dengan prefix icon
                    TextField(
                      controller: _namaController,
                      decoration: _inputDecoration(
                        'Masukkan nama lengkap',
                        Icons.person_outline,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration(
                        'contoh@email.com',
                        Icons.email_outlined,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Password',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    // TextField + suffixIcon IconButton: password dengan toggle visibilitas
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
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Container 2: card berisi jenis kelamin, pendidikan, pengalaman, alamat
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    // Row: dua RadioListTile/Radio disusun sejajar horizontal
                    Row(
                      children: [
                        // Radio<String>: pilihan Laki-laki
                        Radio<String>(
                          value: 'Laki-laki',
                          groupValue: _jenisKelamin,
                          activeColor: Colors.green,
                          onChanged: (val) =>
                              setState(() => _jenisKelamin = val!),
                        ),
                        const Text('Laki-laki'),
                        const SizedBox(width: 24),
                        // Radio<String>: pilihan Perempuan
                        Radio<String>(
                          value: 'Perempuan',
                          groupValue: _jenisKelamin,
                          activeColor: Colors.green,
                          onChanged: (val) =>
                              setState(() => _jenisKelamin = val!),
                        ),
                        const Text('Perempuan'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Pendidikan',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    // DropdownButtonFormField: pilihan pendidikan dari List<String>
                    DropdownButtonFormField<String>(
                      value: _pendidikan,
                      hint: const Text('Pilih pendidikan'),
                      icon: const Icon(Icons.expand_more),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.school_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // map List<String> -> List<DropdownMenuItem>: komposisi item dropdown
                      items: _daftarPendidikan
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _pendidikan = val),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Tingkat Pengalaman',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    // Slider: nilai pengalaman 0-100
                    Slider(
                      value: _pengalaman,
                      min: 0,
                      max: 100,
                      activeColor: Colors.green,
                      onChanged: (val) => setState(() => _pengalaman = val),
                    ),
                    // Row: label ujung kiri "Pemula" & ujung kanan "Ahli"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pemula',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Ahli',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'Alamat',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    // TextField multiline: input alamat (maxLines > 1 = textarea)
                    TextField(
                      controller: _alamatController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Masukkan alamat lengkap',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Icon(Icons.home_outlined),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Container 3: card notifikasi, persetujuan, tombol registrasi
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SwitchListTile: komposisi Row otomatis (title+subtitle+switch) untuk notifikasi
                    SwitchListTile(
                      value: _notifikasi,
                      activeColor: Colors.green,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Notifikasi',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: const Text('Aktifkan notifikasi aplikasi'),
                      onChanged: (val) => setState(() => _notifikasi = val),
                    ),
                    // CheckboxListTile: komposisi Row otomatis (checkbox+text) persetujuan syarat
                    CheckboxListTile(
                      value: _setujuSyarat,
                      activeColor: Colors.green,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text('Saya menyetujui syarat dan ketentuan'),
                      onChanged: (val) =>
                          setState(() => _setujuSyarat = val ?? false),
                    ),
                    const SizedBox(height: 8),

                    // ElevatedButton + Icon: tombol utama REGISTRASI
                    ElevatedButton.icon(
                      onPressed: () {}, // UI only, belum difungsikan
                      icon: const Icon(Icons.shuffle),
                      label: const Text('REGISTRASI'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Row + TextButton: link kembali ke halaman Login
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigator.pushReplacementNamed: ganti halaman Register dengan Login
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                      children: const [
                        TextSpan(text: 'Sudah memiliki akun? '),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // helper method: mengembalikan Container "card" putih dengan shadow tema hijau
  Widget _buildCard({required Widget child}) {
    return Container(
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
      child: child,
    );
  }

  // helper method: dekorasi input seragam untuk TextField sederhana
  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
