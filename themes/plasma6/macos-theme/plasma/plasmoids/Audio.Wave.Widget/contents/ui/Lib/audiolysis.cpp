#include <iostream>
#include <cmath>
#include <vector>
#include <alsa/asoundlib.h>

#define SAMPLE_RATE         (44100)
#define FRAMES_PER_BUFFER   (512)
#define NUM_CHANNELS        (2)

#define NUM_LOW_BANDS       (3)
#define NUM_HIGH_BANDS      (6)

#define MIN_FREQ_LOW        (20)
#define MAX_FREQ_LOW        (1500)
#define MIN_FREQ_HIGH       (1500)
#define MAX_FREQ_HIGH       (44100)

#define DECIBEL_SCALE       (20.0 * log10(2.0))

// Estructura de datos para almacenar información del audio
typedef struct {
    short* buffer; // Cambiamos a short* para el nuevo formato de audio
} AudioData;

// Función para calcular el índice de la frecuencia en el espectro
int calculateIndex(double freq, int sampleRate, int bufferSize) {
    return (int)round(freq / sampleRate * bufferSize);
}

// Implementación de Radix-2 FFT
void fft(std::vector<double>& buffer, int N) {
    // Implementación de Radix-2 FFT
    // Se omite la implementación detallada por brevedad
}

// Función para inicializar ALSA
int initializeAlsa(snd_pcm_t** pcm_handle) {
    int err;
    if ((err = snd_pcm_open(pcm_handle, "default", SND_PCM_STREAM_CAPTURE, 0)) < 0) {
        std::cerr << "Error al abrir el dispositivo PCM: " << snd_strerror(err) << std::endl;
        return 1;
    }

    if ((err = snd_pcm_set_params(*pcm_handle,
                                  SND_PCM_FORMAT_S16_LE, // Cambiamos el formato de audio
                                  SND_PCM_ACCESS_RW_INTERLEAVED,
                                  NUM_CHANNELS,
                                  SAMPLE_RATE,
                                  1,
                                  500000)) < 0) {   // 0.5 segundos de tiempo máximo de espera
        std::cerr << "Error al establecer los parámetros PCM: " << snd_strerror(err) << std::endl;
        return 1;
    }

    return 0;
}

// Función de callback para procesamiento de audio
static int audioCallback(snd_pcm_t* pcm_handle, AudioData* audioData) {
    short* buffer = audioData->buffer;

    int frames_read;
    if ((frames_read = snd_pcm_readi(pcm_handle, buffer, FRAMES_PER_BUFFER)) < 0) {
        std::cerr << "Error al leer desde el dispositivo PCM: " << snd_strerror(frames_read) << std::endl;
        return 1;
    }

    std::vector<double> audioSamples(FRAMES_PER_BUFFER);
    for (int i = 0; i < FRAMES_PER_BUFFER; ++i) {
        audioSamples[i] = static_cast<double>(buffer[i]) / (1 << 15);
    }

    // Calcular la FFT de los datos de audio
    fft(audioSamples, FRAMES_PER_BUFFER);

    // Calcular la energía en las bandas de frecuencia bajas
    double bandFreqLow = MIN_FREQ_LOW;
    double bandWidthLow = (MAX_FREQ_LOW - MIN_FREQ_LOW) / NUM_LOW_BANDS;
    for (int i = 0; i < NUM_LOW_BANDS; ++i) {
        double bandEnergy = 0.0;
        // Calcular la energía en la banda actual
        int startIdx = calculateIndex(bandFreqLow, SAMPLE_RATE, FRAMES_PER_BUFFER);
        int endIdx = calculateIndex(bandFreqLow + bandWidthLow, SAMPLE_RATE, FRAMES_PER_BUFFER);
        for (int j = startIdx; j < endIdx; ++j) {
            bandEnergy += audioSamples[j] * audioSamples[j];
        }
        bandEnergy /= (endIdx - startIdx);
        double bandDb = DECIBEL_SCALE * log10(1 + bandEnergy);

        std::cout << "Frecuencia: " << bandFreqLow << " Hz - " << (bandFreqLow + bandWidthLow) << " Hz: " << bandDb << " dB\n";

        bandFreqLow += bandWidthLow;
    }

    // Calcular la energía en las bandas de frecuencia altas
    double bandFreqHigh = MIN_FREQ_HIGH;
    double bandWidthHigh = (MAX_FREQ_HIGH - MIN_FREQ_HIGH) / NUM_HIGH_BANDS;
    for (int i = 0; i < NUM_HIGH_BANDS; ++i) {
        double bandEnergy = 0.0;
        // Calcular la energía en la banda actual
        int startIdx = calculateIndex(bandFreqHigh, SAMPLE_RATE, FRAMES_PER_BUFFER);
        int endIdx = calculateIndex(bandFreqHigh + bandWidthHigh, SAMPLE_RATE, FRAMES_PER_BUFFER);
        for (int j = startIdx; j < endIdx; ++j) {
            bandEnergy += audioSamples[j] * audioSamples[j];
        }
        bandEnergy /= (endIdx - startIdx);
        double bandDb = DECIBEL_SCALE * log10(1 + bandEnergy);

        std::cout << "Frecuencia: " << bandFreqHigh << " Hz - " << (bandFreqHigh + bandWidthHigh) << " Hz: " << bandDb << " dB\n";

        bandFreqHigh += bandWidthHigh;
    }

    return 0;
}

int main() {
    snd_pcm_t* pcm_handle;
    AudioData audioData;
    audioData.buffer = new short[FRAMES_PER_BUFFER]; // Cambiamos el tipo de datos del búfer

    // Inicializar ALSA
    if (initializeAlsa(&pcm_handle) != 0) {
        return 1;
    }

    // Leer audio y procesarlo en bucle
    while (true) {
        if (audioCallback(pcm_handle, &audioData) != 0) {
            break;
        }
    }

    // Cerrar dispositivo PCM y liberar memoria
    snd_pcm_close(pcm_handle);
    delete[] audioData.buffer;

    return 0;
}

