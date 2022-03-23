all: build

build: simpleMPI

simpleMPI_mpi.o: simpleMPI.cpp
	mpicxx -I../../common/inc -o $@ -c $<

simpleMPI.o: simpleMPI.cu
	/usr/local/cuda-10.2/bin/nvcc -ccbin g++ -I../../common/inc -o $@ -c $<

simpleMPI: simpleMPI_mpi.o simpleMPI.o
	mpicxx -o $@ $+ -L/usr/local/cuda-10.2/lib64 -lcudart
	mkdir -p bin
	cp $@ bin

run: build
	./simpleMPI

clean:
	rm -f simpleMPI simpleMPI_mpi.o simpleMPI.o
	rm -rf bin

clobber: clean
