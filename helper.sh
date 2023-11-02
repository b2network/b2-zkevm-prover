set -x

init() {
    git submodule init
    git submodule update
}

setup() {
    wget https://de012a78750e59b808d922b39535e862.s3.eu-west-1.amazonaws.com/v1.1.0-rc.1-fork.4.tgz
    tar -xzvf v1.1.0-rc.1-fork.4.tgz
    rm -rf config
    mv v1.1.0-rc.1-fork.4/config .
    return
    pacman -S \
        extra/benchmark extra/openmp core/gmp extra/nlohmann-json extra/postgresql extra/libpqxx \
        extra/nasm extra/libsecp256k1 extra/grpc extra/libsodium extra/protobuf extra/protobuf-c core/openssl extra/libcrossguid
}
$@
