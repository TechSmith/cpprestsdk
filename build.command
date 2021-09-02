echo "You need to install cmake for this script to run. i.e...."
echo "\tbrew install cmake"
echo ""
echo "boost and openssl directories are expected to be in a relative path to this script like ../boost*/ and ../openssl*/"

# Getting absolute path to script's directory
relativeScriprtDir="`dirname "$0"`"
cd $relativeScriprtDir
absoluteScriptDir=$(pwd)

# Getting an empty folder to build to
rm -rf build.release
mkdir build.release
cd build.release

# Running cmake and make commands to generate cpprest .lib files
# CMAKE_BUILD_TYPE=Release: Compile in release mode
# BOOST_ROOT=PATH: Aboslute path of boost repo root
# Boost_NO_SYSTEM_PATHS=TRUE: Only look in specified locations for boost
# Boost_NO_BOOST_CMAKE=TRUE: Don't use boost's cmake stuff
# Boost_USE_STATIC_LIBS=TRUE: Use boost statically
# OPENSSL_ROOT_DIR=PATH: Aboslute path of openssl repo root
# OPENSSL_USE_STATIC_LIBS=TRUE: Use openssl statically
# DBUILD_SHARED_LIBS=FALSE: Create static libs for cpprest
# CPPREST_EXCLUDE_WEBSOCKETS=TRUE: Don't compile in usages of websockets module
# CPPREST_EXCLUDE_COMPRESSION=TRUE: Don't compile in usages of compression module
# CPPREST_EXCLUDE_BROTLI=TRUE: Don't compile in usages of brotli module
# BUILD_TESTS=FALSE: Don't build test files
# BUILD_SAMPLES=FALSE: Don't build samples files
# CMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -Wno-c11-extensions": Disable a warning that we see with older versions of boost
cmake   ../Release \
        -DCMAKE_BUILD_TYPE=Release \
        -DBOOST_ROOT="$absoluteScriptDir/../boost-1.67.0-mac-static" \
        -DBoost_NO_SYSTEM_PATHS=TRUE \
        -DBoost_NO_BOOST_CMAKE=TRUE \
        -DBoost_USE_STATIC_LIBS=TRUE \
        -DOPENSSL_ROOT_DIR="$absoluteScriptDir/../openssl-OSX" \
        -DOPENSSL_USE_STATIC_LIBS=TRUE \
        -DBUILD_SHARED_LIBS=FALSE \
        -DCPPREST_EXCLUDE_WEBSOCKETS=TRUE \
        -DCPPREST_EXCLUDE_COMPRESSION=TRUE \
        -DCPPREST_EXCLUDE_BROTLI=TRUE \
        -DBUILD_TESTS=FALSE \
        -DBUILD_SAMPLES=FALSE \
        -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -Wno-c11-extensions" \
        -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64"
make