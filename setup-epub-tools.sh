#!/bin/bash
# EPUB Publishing Tools Setup Script
# Sets up all tools needed for professional EPUB 3, PDF, and Kindle creation and validation.
# Compatible with macOS, Linux, and Windows (via WSL/Git Bash)

set -e  # Exit on any error

echo "🚀 Setting up EPUB Publishing Toolchain…"
echo "This will install: Pandoc, EPUBCheck, DAISY ACE, PrinceXML/WeasyPrint (PDF), Kindle Previewer, and key font/image/CSS tools."
echo ""

# Detect OS
OS=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  OS="macos"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
  OS="windows"
else
  echo "❌ Unsupported OS: $OSTYPE"
  exit 1
fi

echo "🔍 Detected OS: $OS"
echo ""

# Create tools directory
TOOLS_DIR="$HOME/epub-tools"
mkdir -p "$TOOLS_DIR"
cd "$TOOLS_DIR"
echo "📁 Created tools directory: $TOOLS_DIR"
echo ""

# 1. Install Pandoc (>=3.2)
echo "📚 Installing Pandoc…"
if command -v pandoc &> /dev/null; then
  PANDOC_VERSION=$(pandoc --version | head -n1 | cut -d' ' -f2)
  echo "✅ Pandoc already installed (version $PANDOC_VERSION)"
else
  case $OS in
    "macos")
      if command -v brew &> /dev/null; then
        brew install pandoc
      else
        echo "🍺 Installing Homebrew first…"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew install pandoc
      fi
      ;;
    "linux")
      sudo apt-get update
      sudo apt-get install -y pandoc
      ;;
    "windows")
      echo "⚠️  Please download Pandoc manually from: https://pandoc.org/installing.html"
      echo "   Or use: winget install JohnMacFarlane.Pandoc"
      ;;
  esac
fi

# 2. Install Java (required for EPUBCheck and DAISY ACE)
echo ""
echo "☕ Checking Java installation…"
if command -v java &> /dev/null; then
  JAVA_VERSION=$(java -version 2>&1 | head -n1 | cut -d'"' -f2)
  echo "✅ Java already installed (version $JAVA_VERSION)"
else
  case $OS in
    "macos")
      brew install openjdk@11
      echo 'export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"' >> ~/.zshrc
      ;;
    "linux")
      sudo apt-get install -y openjdk-11-jdk
      ;;
    "windows")
      echo "⚠️  Please install Java 11+ from: https://adoptium.net/"
      ;;
  esac
fi

# 3. Install Node.js (required for DAISY ACE)
echo ""
echo "🟢 Checking Node.js installation…"
if command -v node &> /dev/null; then
  NODE_VERSION=$(node --version)
  echo "✅ Node.js already installed (version $NODE_VERSION)"
else
  case $OS in
    "macos")
      brew install node
      ;;
    "linux")
      curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
      sudo apt-get install -y nodejs
      ;;
    "windows")
      echo "⚠️  Please install Node.js from: https://nodejs.org/"
      ;;
  esac
fi

# 4. Install EPUBCheck (5.x)
echo ""
echo "📖 Installing EPUBCheck…"
EPUBCHECK_VERSION="5.1.0"
EPUBCHECK_URL="https://github.com/w3c/epubcheck/releases/download/v${EPUBCHECK_VERSION}/epubcheck-${EPUBCHECK_VERSION}.zip"

if [ ! -f "epubcheck-${EPUBCHECK_VERSION}/epubcheck.jar" ]; then
  wget -O epubcheck.zip "$EPUBCHECK_URL"
  unzip epubcheck.zip
  rm epubcheck.zip
  echo "✅ EPUBCheck installed"
else
  echo "✅ EPUBCheck already installed"
fi

# 5. Install DAISY ACE (Accessibility Checker)
echo ""
echo "♿ Installing DAISY ACE (Accessibility Checker)…"
if command -v ace &> /dev/null; then
  echo "✅ DAISY ACE already installed"
else
  npm install -g @daisy/ace
  echo "✅ DAISY ACE installed"
fi

# 6. Download Kindle Previewer (manual step)
echo ""
echo "📱 Setting up Kindle Previewer…"
echo "📥 Download Kindle Previewer from: https://kdp.amazon.com/en_US/help/topic/G202131170"
echo "   (Manual download required; install and ensure 'kindlepreviewer' is in your PATH)"
echo ""

# 7. (Optional) Install PrinceXML or WeasyPrint for PDF generation
echo "🖨️  PDF/Print tools…"
case $OS in
  "macos")
    echo "Download and install PrinceXML: https://www.princexml.com/download/"
    brew install weasyprint
    ;;
  "linux")
    echo "Download and install PrinceXML: https://www.princexml.com/download/"
    sudo apt-get install -y weasyprint
    ;;
  "windows")
    echo "Download and install PrinceXML: https://www.princexml.com/download/"
    echo "Or WeasyPrint for Windows: https://weasyprint.org/"
    ;;
esac

# 8. (Optional) Install Additional Build Tools (imagemagick, fonttools, stylelint, tidy)
echo ""
echo "🔧 Installing additional asset/validation tools…"
case $OS in
  "macos")
    brew install imagemagick fonttools tidy-html5
    npm install -g stylelint htmllint markdownlint
    ;;
  "linux")
    sudo apt-get install -y imagemagick fonttools tidy
    sudo npm install -g stylelint htmllint markdownlint
    ;;
  "windows")
    echo "⚠️  Install Imagemagick, fonttools, tidy, and NPM tools manually or via Chocolatey"
    ;;
esac

# 9. (Optional) YAML and JSON tools
case $OS in
  "macos")
    brew install yq jq
    ;;
  "linux")
    sudo apt-get install -y yq jq
    ;;
esac

# 10. Add tools to PATH if needed
echo ""
echo "🔧 Setting up PATH…"
BASHRC_FILE=""
case $OS in
  "macos")
    BASHRC_FILE="$HOME/.zshrc"
    ;;
  *)
    BASHRC_FILE="$HOME/.bashrc"
    ;;
esac

if ! grep -q "$TOOLS_DIR" "$BASHRC_FILE" 2>/dev/null; then
  echo "" >> "$BASHRC_FILE"
  echo "# EPUB Publishing Tools" >> "$BASHRC_FILE"
  echo "export PATH=\"$TOOLS_DIR:\$PATH\"" >> "$BASHRC_FILE"
  echo "✅ Added tools to PATH in $BASHRC_FILE"
else
  echo "✅ Tools already in PATH"
fi

echo ""
echo "🎉 All required tools for Manus.im EPUB/PDF/Kindle build are installed or prompted for manual install."
echo "🔗 Check tool versions as needed. Restart terminal or run: source $BASHRC_FILE"
echo ""
echo "📖 Next steps:"
echo "1. Place your manuscript and assets in the project directory"
echo "2. Use your automation scripts, build manifest, and YAML map to build and validate your book"
echo "3. Test your EPUB in Kindle Previewer and run validate-epub/build-epub as needed"
echo ""

