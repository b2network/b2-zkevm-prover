set -x
init() {
    git submodule init
    git submodule update
}

info() {
    exec >"$FUNCNAME.log" 2>&1
    # cloc .
    # find * -iname "*.cpp" -o -iname "*.hpp" -o -iname "*.h" | wc -l
    find * -iname "*.cpp" -o -iname "*.hpp" -o -iname "*.h" | xargs wc -l
}
run() {
    # pacman -Ss protobuf
    # pacman -S protobuf@23
    # protobuf-c
    # return
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib
    ./build/zkProver --help
}

setup() {
    apt update
    apt install build-essential libbenchmark-dev libomp-dev libgmp-dev nlohmann-json3-dev postgresql libpqxx-dev libpqxx-doc nasm libsecp256k1-dev grpc-proto libsodium-dev libprotobuf-dev libssl-dev cmake libgrpc++-dev protobuf-compiler protobuf-compiler-grpc uuid-dev
    return
    # wget https://de012a78750e59b808d922b39535e862.s3.eu-west-1.amazonaws.com/v1.1.0-rc.1-fork.4.tgz
    # tar -xzvf v1.1.0-rc.1-fork.4.tgz
    # rm -rf config
    # mv v1.1.0-rc.1-fork.4/config .
    # return
    pacman -S \
        extra/benchmark extra/openmp core/gmp extra/nlohmann-json extra/postgresql extra/libpqxx \
        extra/nasm extra/libsecp256k1 extra/grpc extra/libsodium extra/protobuf extra/protobuf-c core/openssl extra/libcrossguid
}

builder() {
    # exec > "$FUNCNAME.log" 2>&1
    # docker build --help

    DATE=$(date +%Y%m%d-%H%M%S)
    docker build \
        --tag zkprover-builder:${DATE} \
        --file builder.Dockerfile \
        ./tmp
}

debugImage() {
    docker run \
        --rm \
        -it \
        ghcr.io/b2network/b2-zkevm-prover:20231106-082413-96f7c19 \
        -c '/usr/src/app/config/config.json'
        # --entrypoint bash \
}
$@
