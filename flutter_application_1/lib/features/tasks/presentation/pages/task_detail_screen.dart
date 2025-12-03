import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Controllers untuk Form Input
  final _opmController = TextEditingController();
  final _snController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _opmController.dispose();
    _snController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pengerjaan"),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.amber, // Aksen warna kuning
          indicatorWeight: 4,
          tabs: const [
            Tab(text: "Info", icon: Icon(Icons.info_outline)),
            Tab(text: "Teknis", icon: Icon(Icons.build)), // Survey/OPM
            Tab(text: "Dokumen", icon: Icon(Icons.camera_alt)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildInfoTab(), _buildTeknisTab(), _buildDokumenTab()],
      ),
      // Tombol Submit melayang di bawah
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            // ignore: deprecated_member_use
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1)),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Nanti kita pasang logic Submit ke API/Database di sini
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Data Tugas Disimpan (Lokal)")),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "SELESAIKAN TUGAS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // --- TAB 1: INFORMASI PELANGGAN & PETA ---
  Widget _buildInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Kartu Status
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ticket ID: #${widget.task.id}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                widget.task.title,
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Peta Dummy (Placeholder)
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, size: 50, color: Colors.grey),
                Text("Google Maps View"),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () {}, // Nanti buka Google Maps eksternal
          icon: const Icon(Icons.directions),
          label: const Text("Navigasi ke Lokasi"),
        ),

        const SizedBox(height: 20),
        const Divider(),

        // Detail Alamat
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.red),
          title: const Text("Alamat Pelanggan"),
          subtitle: Text(widget.task.address),
        ),
        ListTile(
          leading: const Icon(Icons.person, color: Colors.blue),
          title: const Text("Nama Pelanggan"),
          subtitle: const Text(
            "Bpk. Budi Santoso (Dummy)",
          ), // Nanti ambil dari entity
        ),
      ],
    );
  }

  // --- TAB 2: INPUT TEKNIS (OPM & SN) ---
  Widget _buildTeknisTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Input Data Lapangan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Input Redaman (OPM)
        TextFormField(
          controller: _opmController,
          keyboardType: TextInputType.number, // Keyboard angka
          decoration: InputDecoration(
            labelText: "Nilai Redaman (OPM)",
            hintText: "Contoh: -18.5",
            suffixText: "dBm",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.network_check),
          ),
        ),
        const SizedBox(height: 16),

        // Input Serial Number dengan Tombol Scan QR
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _snController,
                decoration: InputDecoration(
                  labelText: "Serial Number (ONT)",
                  hintText: "Scan atau ketik manual",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.router),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: () {
                // Nanti pasang fitur QR Scanner di sini
              },
              icon: const Icon(Icons.qr_code_scanner),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        const Text(
          "Checklist Pengerjaan",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CheckboxListTile(
          value: true,
          onChanged: (val) {},
          title: const Text("Kabel Dropcore Terpasang Rapi"),
        ),
        CheckboxListTile(
          value: false,
          onChanged: (val) {},
          title: const Text("Labeling ODP Sesuai"),
        ),
      ],
    );
  }

  // --- TAB 3: DOKUMENTASI FOTO ---
  Widget _buildDokumenTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Area Upload Foto 1 (Sebelum)
          _buildPhotoUploader("Foto Sebelum Pengerjaan (ODP)"),
          const SizedBox(height: 16),
          // Area Upload Foto 2 (Sesudah)
          _buildPhotoUploader("Foto Sesudah Pengerjaan (Rumah)"),
        ],
      ),
    );
  }

  Widget _buildPhotoUploader(String label) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade50,
        ),
        child: InkWell(
          onTap: () {
            // Nanti panggil Image Picker (Kamera)
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_a_photo, size: 40, color: Colors.grey.shade600),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),
        ),
      ),
    );
  }
}
