CC = gcc
FLAGS = -Wall -g

all: loops mains maindrec maindloop

mains: main.o libclassrec.a
	$(CC) $(FLAGS) -o mains main.o libclassrec.a
maindloop: main.o loopd
	$(CC) $(FLAGS) -o maindloop main.o ./libclassloops.so
maindrec: main.o recursived
	$(CC) $(FLAGS) -o maindrec main.o ./libclassrec.so
loops:libclassloops.a 
libclassloops.a :advancedClassificationLoop.o basicClassification.o
	ar -rc libclassloops.a advancedClassificationLoop.o basicClassification.o
recursive: libclassrec.a
libclassrec.a:advancedClassificationRecursion.o basicClassification.o
	ar -rc libclassrec.a advancedClassificationRecursion.o basicClassification.o
recursived:libclassrec.so
libclassrec.so: advancedClassificationRecursion.o basicClassification.o
	$(CC) -shared -o libclassrec.so advancedClassificationRecursion.o basicClassification.o
loopd:libclassloops.so
libclassloops.so: advancedClassificationLoop.o basicClassification.o
	$(CC) -shared -o libclassloops.so advancedClassificationLoop.o basicClassification.o
advancedClassificationLoop.o: advancedClassificationLoop.c NumClass.h
	$(CC) -c advancedClassificationLoop.c
advancedClassificationRecursion.o: advancedClassificationRecursion.c NumClass.h
	$(CC) -c advancedClassificationRecursion.c
basicClassification.o: basicClassification.c NumClass.h
	$(CC) -c basicClassification.c
main.o: main.c NumClass.h 
	$(CC) $(FLAGS) -c main.c
.PHONY: clean all
clean:
	 rm -f *.o *.a *.so mains maindloop maindrec

