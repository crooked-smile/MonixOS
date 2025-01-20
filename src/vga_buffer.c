//
// Created by crooked on 1/19/25.
//

#include "vga_buffer.h"

char* BUFFER = (char*) 0xB8000;

void vga_buffer_init()
{
    unsigned int i = 0;
    while(i < 80 * 25 * 2) {
        BUFFER[i] = 0x00;
        i++;
    }
}