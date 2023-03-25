#include "pico/stdlib.h"

int main() {
  for (;;)
    tight_loop_contents(); // noreturn
}
