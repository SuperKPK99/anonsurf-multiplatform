# AnonSurf Multi-Platform Paketleme Kılavuzu

Bu belge, AnonSurf Multi-Platform projesinin farklı Linux dağıtımları için paketleme işlemlerini açıklar.

## Otomatik Paketleme Betiği

`build-all-packages.sh` betiği, herhangi bir Linux dağıtımında çalıştırılabilir ve üç farklı paket formatını (.deb, .rpm ve .pkg.tar.zst) otomatik olarak oluşturur. Bu betik, hangi dağıtımı kullandığınız önemli olmaksızın tüm paket formatları için aynı anda yapı işlemi gerçekleştirir.

### Kullanım

1. Betiği çalıştırılabilir yapın:
   ```bash
   chmod +x build-all-packages.sh
   ```

2. Betiği çalıştırın:
   ```bash
   ./build-all-packages.sh
   ```

3. İşlem tamamlandığında, aşağıdaki paketler `packages` dizininde oluşturulacaktır:
   - `anonsurf-multiplatform_1.0.0-1_amd64.deb` (Debian/Ubuntu)
   - `anonsurf-multiplatform-1.0.0-1.fc38.x86_64.rpm` (Fedora/RHEL/CentOS)
   - `anonsurf-multiplatform-1.0.0-1-x86_64.pkg.tar.zst` (Arch Linux)

## Paket Yapısı

Oluşturulan paketler şu dosyaları içerecektir:

```
/usr/bin/anonsurf                          # CLI aracı
/usr/sbin/anonsurfd                        # Daemon çalıştırılabilir dosyası
/usr/lib/anonsurf/anonsurf_gtk_vala.so     # GUI kitaplığı
/usr/lib/anonsurf/anondaemon               # AnonSurf Tor sarmalayıcı betiği
/usr/lib/anonsurf/safekill                 # Uygulamaları sonlandırma betiği
/usr/share/applications/anonsurf-gtk.desktop # Uygulama başlatıcısı
/etc/anonsurf/torrc.base                   # Temel Tor yapılandırması
/usr/lib/systemd/system/anonsurfd.service  # Systemd servisi
/var/lib/anonsurf/                         # Çalışma zamanı veri dizini
```

## Manuel Paketleme

Her dağıtım için manuel paketleme adımları aşağıda açıklanmıştır.

### Debian/Ubuntu (.deb)

```bash
# Gerekli paketleri yükleyin
sudo apt-get update
sudo apt-get install -y devscripts debhelper nim valac libgtk-3-dev libnotify-dev

# Proje kök dizinine gidin
cd anonsurf-multiplatform

# Kaynak tarball'ını oluşturun
cd ..
tar -czf anonsurf-multiplatform_1.0.0.orig.tar.gz anonsurf-multiplatform
cd anonsurf-multiplatform

# Paketi derleyin
debuild -us -uc

# .deb paketi üst dizinde oluşturulacak
```

### Fedora/RHEL/CentOS (.rpm)

```bash
# Gerekli paketleri yükleyin
sudo dnf install -y rpm-build nim vala gtk3-devel libnotify-devel
# veya
sudo yum install -y rpm-build nim vala gtk3-devel libnotify-devel

# RPM yapı dizini oluşturun
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Spec dosyasını kopyalayın
cp packaging/rpm/anonsurf-multiplatform.spec ~/rpmbuild/SPECS/

# Kaynak tarball'ını oluşturun
cd ..
tar -czf ~/rpmbuild/SOURCES/anonsurf-multiplatform-1.0.0.tar.gz anonsurf-multiplatform

# Paketi derleyin
rpmbuild -ba ~/rpmbuild/SPECS/anonsurf-multiplatform.spec

# RPM paketi ~/rpmbuild/RPMS/{mimariniz}/ dizininde olacak
```

### Arch Linux (.pkg.tar.zst)

```bash
# Gerekli paketleri yükleyin
sudo pacman -S --needed base-devel nim vala gtk3

# Yapı dizini oluşturun
mkdir -p build-arch && cd build-arch

# PKGBUILD dosyasını kopyalayın
cp ../packaging/arch/PKGBUILD .

# Kaynak tarball'ını oluşturun
cd ..
tar -czf build-arch/anonsurf-multiplatform-1.0.0.tar.gz anonsurf-multiplatform

# Paketi derleyin
cd build-arch
makepkg -s

# Paket mevcut dizinde oluşturulacak
```

## Bağımlılıklar

- tor: Tor anonimlik ağı
- iptables: IP paket filtreleme çerçevesi
- gtk3: GTK+ 3 kitaplıkları (GUI için)
- systemd: Sistem ve servis yöneticisi
- İsteğe bağlı: nyx (Tor izleme), bleachbit (sistem temizleyici) 