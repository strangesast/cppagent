FROM debian

RUN apt-get update && apt-get -y install git build-essential cmake libxml2-dev libcppunit-dev ruby curl
RUN git clone --recurse-submodules https://github.com/strangesast/mtconnect-cppagent.git

RUN cd mtconnect-cppagent && \
  mkdir build && cd build && \
  cmake --config Release .. && \
  cmake --build . --config Release --target agent && \
  make

WORKDIR /mtconnect-cppagent/build

COPY unix/agent.cfg .
COPY fanuc.xml .

CMD ["./agent/agent", "run"]
