#include <iostream>
#include <unistd.h>
#include <sys/wait.h>
#include <cstring>
#include <cerrno>
#include <libgen.h> // Para dirname

int main() {
    int pipefd[2];
    if (pipe(pipefd) == -1) {
        std::cerr << "Error al crear el pipe: " << strerror(errno) << std::endl;
        return 1;
    }

    pid_t pid = fork();
    if (pid == -1) {
        std::cerr << "Error al crear el proceso hijo: " << strerror(errno) << std::endl;
        return 1;
    }

    if (pid == 0) { // Proceso hijo
        close(pipefd[0]);
        dup2(pipefd[1], STDOUT_FILENO);

        char program_path[1024];
        if (readlink("/proc/self/exe", program_path, sizeof(program_path)) == -1) {
            std::cerr << "Error al obtener la ruta del programa capturador: " << strerror(errno) << std::endl;
            return 1;
        }

        char* program_dir = dirname(program_path);
        if (chdir(program_dir) == -1) {
            std::cerr << "Error al cambiar el directorio de trabajo: " << strerror(errno) << std::endl;
            return 1;
        }

        if (execl("./audio_fft", "audio_fft", "default", NULL) == -1) {
            std::cerr << "Error al ejecutar el programa hijo: " << strerror(errno) << std::endl;
            return 1;
        }
    } else { // Proceso padre
        close(pipefd[1]);
        const int BUFFER_SIZE = 550; // Ajustar según sea necesario
        char buffer[BUFFER_SIZE];
        memset(buffer, 0, BUFFER_SIZE);
        ssize_t total_bytes_read = 0;
        ssize_t bytes_read;
        while ((bytes_read = read(pipefd[0], buffer + total_bytes_read, BUFFER_SIZE - total_bytes_read)) > 0) {
            total_bytes_read += bytes_read;
        }
        if (bytes_read == -1) {
            std::cerr << "Error al leer del pipe: " << strerror(errno) << std::endl;
            return 1;
        }

        buffer[total_bytes_read] = '\0';

        kill(pid, SIGKILL);

        std::cout << "Salida del programa anterior:" << std::endl;
        std::cout << buffer << std::endl;

        int status;
        waitpid(pid, &status, 0);
    }

    return 0;
}
