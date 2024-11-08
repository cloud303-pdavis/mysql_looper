FROM debian

RUN apt-get update && apt-get install -y build-essential libmariadb-dev-compat libmariadb-dev cmake

ADD *.c CMakeLists.txt /src/
RUN ls /src

RUN mkdir /src/build

WORKDIR /src/build

RUN cmake ..

RUN make

ENTRYPOINT ["/src/build/mysql_looperd"]
