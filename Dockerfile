FROM debian AS build

RUN apt-get update && apt-get install -y build-essential libmariadb-dev-compat libmariadb-dev cmake

ADD *.c CMakeLists.txt /src/

RUN mkdir /src/build

WORKDIR /src/build

RUN cmake ..

RUN make

FROM debian

RUN apt-get update && apt-get install -y \
  libmariadb3 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /src/build/mysql_looperd /usr/local/bin/mysql_looperd

ENTRYPOINT ["/usr/local/bin/mysql_looperd"]
