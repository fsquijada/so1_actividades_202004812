#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int sum; // Para la suma de un hilo
int unique_processes = 1; // Para cantidad de procesos unicos
int unique_threads = 1; // Para cantidad de hilos unicos

void *runner(void *param) {
    int i, upper = atoi(param); // Convierte el parametro a un entero
    sum = 0;

    for (i = 1; i <= upper; i++)
        sum += i;

    pthread_exit(0);
}

int main(int argc, char *argv[])
{
    pthread_t tid; // Identificador del hilo
    pthread_attr_t attr; // Atributos del hilo

    pthread_attr_init(&attr); // Coloca en su valor default el atributo del hilo
    pthread_create(&tid, &attr, runner, argv[1]); // Crea el hilo
    pthread_join(tid, NULL); // Espera a que el hilo finalice

    // Incrementa el numero de procesos unicos
    unique_processes++;

    // Fork para crear un nuevo proceso hijo
    pid_t pid;
    pid = fork();

    if (pid == 0) {
        // Procesos hijos
        pthread_t tid_child;
        pthread_create(&tid_child, &attr, runner, argv[1]);
        pthread_join(tid_child, NULL);

        // Incrementa el contador de hilos para el hilo hijo
        unique_threads++;
        
        printf("Procesos hijos - %d\n", sum);
    } else if (pid > 0) {
        // Se ejecuta en el proceso padre
        printf("Procesos padres - %d\n", sum);
    } else {
        printf("Error al ejecutar el proceso");
    }

    printf("Cantidad de procesos unicos: %d\n", unique_processes);
    printf("Cantidad de hilos unicos: %d\n", unique_threads);

    return 0;
}

