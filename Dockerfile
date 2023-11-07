FROM ghcr.io/b2network/b2-zkevm-prover-builder:20231103-172203-f5fd1aa as build
WORKDIR /usr/src/app

COPY ./src ./src
COPY ./test ./test
COPY ./tools ./tools
COPY ./config ./config
COPY Makefile .
RUN make -j 5

FROM ubuntu:22.04
WORKDIR /app
RUN apt update && apt install -y build-essential libgmp-dev nlohmann-json3-dev libsecp256k1-dev libomp-dev libpqxx-dev libssl-dev libgrpc++-dev libprotobuf-dev grpc-proto libsodium-dev protobuf-compiler protobuf-compiler-grpc uuid-dev

COPY --from=build /usr/src/app/build/zkProver /usr/local/bin
COPY ./testvectors ./testvectors
COPY ./config ./config
COPY ./src/main_sm/fork_1/scripts/rom.json ./src/main_sm/fork_1/scripts/rom.json
COPY ./src/main_sm/fork_2/scripts/rom.json ./src/main_sm/fork_2/scripts/rom.json
COPY ./src/main_sm/fork_3/scripts/rom.json ./src/main_sm/fork_3/scripts/rom.json
COPY ./src/main_sm/fork_4/scripts/rom.json ./src/main_sm/fork_4/scripts/rom.json
COPY ./src/main_sm/fork_5/scripts/rom.json ./src/main_sm/fork_5/scripts/rom.json
COPY ./src/main_sm/fork_6/scripts/rom.json ./src/main_sm/fork_6/scripts/rom.json

ENTRYPOINT [ "zkProver" ]
