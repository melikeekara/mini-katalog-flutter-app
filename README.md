
# 📱 Mini Katalog Flutter Uygulaması

Bu proje, Flutter haftalık eğitim programı kapsamında geliştirilmiş
temel seviye fakat profesyonel tasarım prensiplerine uygun bir mobil
katalog uygulamasıdır.

Amaç; Flutter ile mobil uygulama geliştirme sürecini baştan sona
öğrenmek ve aşağıdaki temel konulara hâkim olmaktır:

- Widget yapısı
- Sayfa navigasyonu
- JSON veri modelleme
- Grid tabanlı tasarım
- Basit state yönetimi
- Asset yönetimi
- Modern Material 3 tasarım prensipleri

---

# 🚀 Uygulama Özellikleri

## 🏠 Ana Sayfa
- GridView ile kart tabanlı ürün listeleme
- Arama özelliği (başlık ve kategori filtreleme)
- Kategori bazlı filtreleme (ChoiceChip)
- Dinamik ürün sayısı
- Modern banner tasarımı
- Sepet badge göstergesi

## 📦 Ürün Detay Sayfası
- Route Arguments ile veri aktarımı
- Hero animasyonu
- Ürün açıklaması
- Fiyat etiketi
- Sepete ekleme butonu
- Sepetteyse buton pasif hale gelir

## 🛒 Sepet Sayfası
- Eklenen ürünlerin listelenmesi
- Ürün kaldırma
- Sepeti temizleme
- Toplam fiyat hesaplama
- Satın alma simülasyonu (Dialog)
- Boş sepet için özel Empty State tasarımı

---

# 🛠️ Kullanılan Teknolojiler

- Flutter SDK
- Dart
- Material 3 (useMaterial3: true)
- Android Emulator
- Visual Studio Code

> Bu projede ekstra paket kullanılmamıştır.
> Tamamen temel Flutter bileşenleri ile geliştirilmiştir.

---

# 📂 Proje Klasör Yapısı

```

lib/
├── core/
│    ├── app_routes.dart
│    └── formatters.dart
│
├── data/
│    └── product_repository.dart
│
├── models/
│    └── product.dart
│
├── screens/
│    ├── home_screen.dart
│    ├── product_detail_screen.dart
│    └── cart_screen.dart
│
├── state/
│    └── cart_state.dart
│
├── widgets/
│    ├── product_card.dart
│    └── empty_state.dart
│
└── main.dart

---

# 🖥️ Kurulum ve Çalıştırma

### 1️⃣ Projeyi Klonla

```

git clone [https://github.com/kullaniciadi/mini-katalog-flutter.git](https://github.com/kullaniciadi/mini-katalog-flutter.git)

```

### 2️⃣ Proje klasörüne gir

```

cd mini-katalog-flutter

```

### 3️⃣ Bağımlılıkları yükle

```

flutter pub get

```

### 4️⃣ Uygulamayı çalıştır

```

flutter run

```

Eğer emulator grafik sorunu yaşanırsa:

```

flutter run --no-enable-impeller

```

# 📸  Ekran fotoğrafı:
<img width="397" height="887" alt="anasayfa" src="https://github.com/user-attachments/assets/de57b5ea-928a-4c1a-82c0-2a3c61a12fe3" />

```

---

# 📌 Not

Bu uygulama gerçek bir e-ticaret sistemi değildir.
Eğitim ve demo amaçlı geliştirilmiştir.

---

# 👩‍💻 Geliştirici

Melike Kara

---



