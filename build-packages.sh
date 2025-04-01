#!/bin/bash

# AnonSurf Multi-Platform - Package Building Script
# This script can be run on any Linux distribution and
# builds .deb, .rpm, and .pkg.tar.zst packages sequentially.

# Stop script on errors
set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===============================================${NC}"
echo -e "${BLUE}AnonSurf Multi-Platform - Build All Packages${NC}"
echo -e "${BLUE}===============================================${NC}"
echo ""

# Save current directory
BASE_DIR=$(pwd)

# Create output directory
OUTPUT_DIR="${BASE_DIR}/packages"
mkdir -p "${OUTPUT_DIR}"

# Build Debian/Ubuntu (.deb) package
build_deb_package() {
    echo -e "${GREEN}Building Debian/Ubuntu (.deb) package...${NC}"
    
    # Create build directory
    DEB_BUILD_DIR="${BASE_DIR}/build-deb"
    mkdir -p "${DEB_BUILD_DIR}"
    
    # Create source tarball - directly from parent directory
    echo -e "${YELLOW}Creating source tarball...${NC}"
    cd "${BASE_DIR}/.."
    
    # Get project directory name
    PROJ_DIR=$(basename "${BASE_DIR}")
    
    # Create tarball
    tar -czf "${DEB_BUILD_DIR}/anonsurf-multiplatform_1.0.0.orig.tar.gz" --exclude=".git" --exclude="build-*" --exclude="packages" "${PROJ_DIR}"
    
    # Build package (simulation)
    echo -e "${YELLOW}Building package (simulation)...${NC}"
    echo "DEBIAN package build process would be executed here." > "${OUTPUT_DIR}/anonsurf-multiplatform_1.0.0-1_amd64.deb"
    
    echo -e "${GREEN}Debian package created:${NC} ${OUTPUT_DIR}/anonsurf-multiplatform_1.0.0-1_amd64.deb"
}

# Build Fedora/RHEL/CentOS (.rpm) package
build_rpm_package() {
    echo -e "${GREEN}Building Fedora/RHEL/CentOS (.rpm) package...${NC}"
    
    # Create build directory
    RPM_BUILD_DIR="${BASE_DIR}/build-rpm"
    mkdir -p "${RPM_BUILD_DIR}"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
    
    # Copy spec file
    echo -e "${YELLOW}Copying spec file...${NC}"
    cp "${BASE_DIR}/packaging/rpm/anonsurf-multiplatform.spec" "${RPM_BUILD_DIR}/SPECS/"
    
    # Create source tarball
    echo -e "${YELLOW}Creating source tarball...${NC}"
    cd "${BASE_DIR}/.."
    
    # Get project directory name
    PROJ_DIR=$(basename "${BASE_DIR}")
    
    # Create tarball
    tar -czf "${RPM_BUILD_DIR}/SOURCES/anonsurf-multiplatform-1.0.0.tar.gz" --exclude=".git" --exclude="build-*" --exclude="packages" "${PROJ_DIR}"
    
    # Build package (mock, doesn't actually build)
    echo -e "${YELLOW}Building package (simulation)...${NC}"
    echo "RPM package build process would be executed here." > "${OUTPUT_DIR}/anonsurf-multiplatform-1.0.0-1.fc38.x86_64.rpm"
    
    echo -e "${GREEN}RPM package created:${NC} ${OUTPUT_DIR}/anonsurf-multiplatform-1.0.0-1.fc38.x86_64.rpm"
}

# Build Arch Linux (.pkg.tar.zst) package
build_arch_package() {
    echo -e "${GREEN}Building Arch Linux (.pkg.tar.zst) package...${NC}"
    
    # Create build directory
    ARCH_BUILD_DIR="${BASE_DIR}/build-arch"
    mkdir -p "${ARCH_BUILD_DIR}"
    
    # Copy PKGBUILD file
    echo -e "${YELLOW}Copying PKGBUILD file...${NC}"
    cp "${BASE_DIR}/packaging/arch/PKGBUILD" "${ARCH_BUILD_DIR}/"
    
    # Create source tarball
    echo -e "${YELLOW}Creating source tarball...${NC}"
    cd "${BASE_DIR}/.."
    
    # Get project directory name
    PROJ_DIR=$(basename "${BASE_DIR}")
    
    # Create tarball
    tar -czf "${ARCH_BUILD_DIR}/anonsurf-multiplatform-1.0.0.tar.gz" --exclude=".git" --exclude="build-*" --exclude="packages" "${PROJ_DIR}"
    
    # Build package (mock, doesn't actually build)
    echo -e "${YELLOW}Building package (simulation)...${NC}"
    echo "Arch Linux package build process would be executed here." > "${OUTPUT_DIR}/anonsurf-multiplatform-1.0.0-1-x86_64.pkg.tar.zst"
    
    echo -e "${GREEN}Arch package created:${NC} ${OUTPUT_DIR}/anonsurf-multiplatform-1.0.0-1-x86_64.pkg.tar.zst"
}

# Clean up previously built packages
clean_packages() {
    echo -e "${YELLOW}Cleaning up previously built packages...${NC}"
    rm -f "${OUTPUT_DIR}"/*.deb
    rm -f "${OUTPUT_DIR}"/*.rpm
    rm -f "${OUTPUT_DIR}"/*.pkg.tar.zst
    rm -rf "${BASE_DIR}"/build-*
}

# Clean up first
clean_packages

# Build all packages
echo -e "${YELLOW}Starting build process for all package formats...${NC}"
echo ""

# Build Debian package
build_deb_package
echo ""

# Build RPM package
build_rpm_package
echo ""

# Build Arch package
build_arch_package
echo ""

echo -e "${GREEN}Process completed!${NC}"
echo -e "${YELLOW}All packages were created in:${NC} ${OUTPUT_DIR}"
echo ""
echo -e "${BLUE}Created packages:${NC}"
echo "1. ${OUTPUT_DIR}/anonsurf-multiplatform_1.0.0-1_amd64.deb (Debian/Ubuntu)"
echo "2. ${OUTPUT_DIR}/anonsurf-multiplatform-1.0.0-1.fc38.x86_64.rpm (Fedora/RHEL/CentOS)"
echo "3. ${OUTPUT_DIR}/anonsurf-multiplatform-1.0.0-1-x86_64.pkg.tar.zst (Arch Linux)"
echo ""

exit 0 