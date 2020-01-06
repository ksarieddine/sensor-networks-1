#include "Timer.h"


module BlinkC @safe()
{

  uses interface Timer<TMilli> as Timer0;
  uses interface Leds;
  uses interface Boot;
}
implementation
{
  enum { WARN_INTERVAL = 6000, WARN_DURATION = 5000 };
  
  event void Timer0.fired(){
    if( call Leds.get() & LEDS_LED0)
    {
      call Leds.led0Off();
      call Leds.led1Off();
      call Leds.led2Off();
      call Timer0.startOneShot(WARN_INTERVAL - WARN_DURATION);
    }
    else
    {
      call Leds.led0On();
      call Leds.led1On();
      call Leds.led2On();
      call Timer0.startOneShot(WARN_DURATION);
    }
  }

  event void Boot.booted()
  {
    signal Timer0.fired();
  }
}
