# AnonSurf Multi-Platform

AnonSurf Multi-Platform, internet trafiğini Tor ağı üzerinden yönlendirerek çeşitli Linux dağıtımlarında kullanıcılar için gizlilik ve anonimlik sağlayan kapsamlı bir anonimleştirme aracıdır.

Bu araç, orijinal [ParrotSec/anonsurf](https://github.com/ParrotSec/anonsurf) projesinin birden fazla Linux dağıtımında sorunsuz çalışacak şekilde geliştirilmiş bir forkudur.

## Özellikler

- **Çoklu Platform Uyumluluğu**: Debian-tabanlı, Arch-tabanlı ve RPM-tabanlı Linux dağıtımlarında çalışır
- **Şeffaf Tor Proxy**: Tüm internet trafiğini Tor üzerinden yönlendirir
- **IP/DNS Sızıntı Koruması**: Gerçek IP adresinizin kazara açığa çıkmasını önler
- **Basit Arayüz**: Kullanımı kolay komut satırı ve GUI arayüzleri
- **Sistem Servisi Entegrasyonu**: Başlangıçta etkinleştirilebilir/devre dışı bırakılabilir
- **Kimlik Yönetimi**: Tek bir komutla Tor kimliğinizi değiştirin

## Gereksinimler

- Linux işletim sistemi (Debian/Ubuntu, Arch, Fedora/RHEL, vb.)
- Tor paketi
- GUI modu için: GTK3 ortamı

## Kurulum

### Kaynak Koddan

1. Depoyu klonlayın:
```bash
git clone https://github.com/kullaniciadi/anonsurf-multiplatform.git
cd anonsurf-multiplatform
```

2. Projeyi derleyin:
```bash
make
```

3. Yükleyin:
```bash
sudo make install
```

### Dağıtıma özgü paketler

#### Debian/Ubuntu
```bash
sudo dpkg -i anonsurf-multiplatform_1.0.0_amd64.deb
sudo apt install -f
```

#### Arch Linux
```bash
sudo pacman -U anonsurf-multiplatform-1.0.0-1-x86_64.pkg.tar.zst
```

#### Fedora/RHEL
```bash
sudo dnf install anonsurf-multiplatform-1.0.0-1.fc38.x86_64.rpm
```

## Kullanım

### Komut Satırı Arayüzü

```bash
# Mevcut IP'nizi kontrol edin
anonsurf myip

# Anonimleştirmeyi başlatın
sudo anonsurf start

# Durumu kontrol edin
anonsurf status

# Tor kimliğini değiştirin
sudo anonsurf changeid

# Anonimleştirmeyi durdurun
sudo anonsurf stop

# Başlangıçta etkinleştirin
sudo anonsurf enable-boot

# Başlangıçta devre dışı bırakın
sudo anonsurf disable-boot
```

### Grafiksel Arayüz

GUI uygulamasını uygulama menünüzden veya aşağıdaki komutu çalıştırarak başlatın:

```bash
anonsurf-gtk
```

## Yakında Gelecek Özellikler

- Gelişmiş bağlantı yönetimi için NetworkManager entegrasyonu
- Ek güvenlik katmanları için OpenVPN entegrasyonu
- Alternatif anonimleştirme için I2P ağ desteği

## Güvenlik Notları

- AnonSurf anonimlik sağlasa da, tamamen kusursuz değildir. Her zaman güvenli gezinme alışkanlıkları uygulayın.
- AnonSurf kullanırken güvenilmeyen programları çalıştırmayın, çünkü potansiyel olarak Tor proxy'sini atlatabilirler.
- En yüksek güvenlik için, özellikle anonimlik için tasarlanmış Tails veya Whonix gibi işletim sistemlerini düşünün.

## Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen bir Pull Request göndermekten çekinmeyin.

## Lisans

Bu proje GNU GPL v2 Lisansı altında lisanslanmıştır - ayrıntılar için LICENSE dosyasına bakın.

## Teşekkürler

- Orijinal [ParrotSec AnonSurf](https://github.com/ParrotSec/anonsurf) ekibi
- Çevrimiçi gizlilik ve anonimlik konusundaki inanılmaz çalışmaları için Tor Projesi
- Bu forkun tüm katkıda bulunanları 