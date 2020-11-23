BASE = $FE000000  ; use $3F000000 for RP2B, 3B, 3B+
GPIO_OFFSET = $200000
TIMER_OFFSET = $3000

mov r0,BASE
orr r0,GPIO_OFFSET

forwards: ; loop for when we want to count forwards
  bl SleepBackwards ; initial sleep to throw away any extra input from a longish button press
  bl Draw1 ; draw a 1 onscreen
  bl SleepForwards ; sleep for a second and poll input
  bl Draw2 ;etc.
  bl SleepForwards
  bl Draw3
  bl SleepForwards
  bl Draw4
  bl SleepForwards
  bl Draw5
  bl SleepForwards
  bl Draw6
  bl SleepForwards
  bl Draw7
  bl SleepForwards
  bl Draw8
  bl SleepForwards
  bl Draw9
  bl SleepForwards
  b forwards ; restart loop
backwards: ; loop for when we want to count backwards
  bl SleepForwards ; initial sleep to throw away any extra input from a longish button press
  bl Draw9 ; draw a 9 onscreen
  bl SleepBackwards ; sleep for a second and poll input
  bl Draw8 ; etc.
  bl SleepBackwards
  bl Draw7
  bl SleepBackwards
  bl Draw6
  bl SleepBackwards
  bl Draw5
  bl SleepBackwards
  bl Draw4
  bl SleepBackwards
  bl Draw3
  bl SleepBackwards
  bl Draw2
  bl SleepBackwards
  bl Draw1
  bl SleepBackwards
  b backwards ; restart loop

SleepForwards: ; sleeps for 1 second and polls for input, if button is pressed, jumps to backwards loop
  mov r3,BASE
  orr r3,TIMER_OFFSET ; timer register address
  mov r4,$f4000 ; first part of 10000000 microseconds value
  orr r4,$00240 ; second part
  ldrd r6,r7,[r3,#4] ; load current time
  mov r5,r6 ; make a copy of current time to check later
  timerloopforwards:
    ; check input
    ldr r9,[r0,#52] ; read gpios 0-31
    tst r9,#131072  ; use tst to check bit 17
    bne backwards ; if == 0
    ldrd r6,r7,[r3,#4] ; update time
    sub r8,r6,r5 ; calculate time diff
    cmp r8,r4 ; compare time diff to delay
    bls timerloopforwards ; branch if ready

  bx lr

SleepBackwards: ; sleeps for 1 second and polls for input, if button is pressed, jumps to forwards loop
  mov r3,BASE
  orr r3,TIMER_OFFSET ; timer register address
  mov r4,$f4000 ; first part of 10000000 microseconds value
  orr r4,$00240 ; second part
  ldrd r6,r7,[r3,#4] ; load current time
  mov r5,r6 ; make a copy of current time to check later
  timerloopbackwards:
    ; check input
    ldr r9,[r0,#52] ; read gpios 0-31
    tst r9,#131072  ; use tst to check bit 17
    bne forwards ; if == 0
    ldrd r6,r7,[r3,#4] ; update time
    sub r8,r6,r5 ; calculate time diff
    cmp r8,r4 ; compare time diff to delay
    bls timerloopbackwards ; branch if ready

  bx lr

Draw1:
  ; 16
  mov r1,#1
  lsl r1,#18
  str r1,[r0,#4]
  mov r1,#1
  lsl r1,#16
  str r1,[r0,#28]
  ; 21
  mov r1,#1
  lsl r1,#3
  str r1,[r0,#8]
  mov r1,#1
  lsl r1,#21
  str r1,[r0,#28]

  bx lr

Draw2:
  ; 12, 15
  mov r1,#1
  lsl r1,#6
  mov r2,#1
  lsl r2,#15
  orr r1,r2
  str r1,[r0,#4]
  ; 12
  mov r1,#1
  lsl r1,#12
  str r1,[r0,#28]
  ; 15
  mov r1,#1
  lsl r1,#15
  str r1,[r0,#28]
  ; 21, 24, 25
  mov r1,#1
  lsl r1,#3
  mov r2,#1
  lsl r2,#12
  mov r3,#1
  lsl r3,#15
  orr r1,r2
  orr r1,r3
  str r1,[r0,#8]
  ; 21
  mov r1,#1
  lsl r1,#21
  str r1,[r0,#28]
  ; 24
  mov r1,#1
  lsl r1,#24
  str r1,[r0,#28]
  ; 25
  mov r1,#1
  lsl r1,#25
  str r1,[r0,#28]

  bx lr

Draw3:
  ; 12, 15, 16
  mov r1,#1
  lsl r1,#6
  mov r2,#1
  lsl r2,#15
  mov r3,#1
  lsl r3,#18
  orr r1,r2
  orr r1,r3
  str r1,[r0,#4]
  ; 12
  mov r1,#1
  lsl r1,#12
  str r1,[r0,#28]
  ; 15
  mov r1,#1
  lsl r1,#15
  str r1,[r0,#28]
  ; 16
  mov r1,#1
  lsl r1,#16
  str r1,[r0,#28]
  ; 21, 24
  mov r1,#1
  lsl r1,#3
  mov r2,#1
  lsl r2,#12
  orr r1,r2
  str r1,[r0,#8]
  ; 21
  mov r1,#1
  lsl r1,#21
  str r1,[r0,#28]
  ; 24
  mov r1,#1
  lsl r1,#24
  str r1,[r0,#28]

  bx lr

Draw4:
  ; 15, 16, 18
  mov r1,#1
  lsl r1,#15
  mov r2,#1
  lsl r2,#18
  mov r3,#1
  lsl r3,#24
  orr r1,r2
  orr r1,r3
  str r1,[r0,#4]
  ; 15
  mov r1,#1
  lsl r1,#15
  str r1,[r0,#28]
  ; 16
  mov r1,#1
  lsl r1,#16
  str r1,[r0,#28]
  ; 18
  mov r1,#1
  lsl r1,#18
  str r1,[r0,#28]
  ; 21
  mov r1,#1
  lsl r1,#3
  str r1,[r0,#8]
  mov r1,#1
  lsl r1,#21
  str r1,[r0,#28]

  bx lr

Draw5:
  ; 12, 15, 16, 18
  mov r1,#1
  lsl r1,#6
  mov r2,#1
  lsl r2,#15
  mov r3,#1
  lsl r3,#18
  mov r4,#1
  lsl r4,#24
  orr r1,r2
  orr r1,r3
  orr r1,r4
  str r1,[r0,#4]
  ; 12
  mov r1,#1
  lsl r1,#12
  str r1,[r0,#28]
  ; 15
  mov r1,#1
  lsl r1,#15
  str r1,[r0,#28]
  ; 16
  mov r1,#1
  lsl r1,#16
  str r1,[r0,#28]
  ; 18
  mov r1,#1
  lsl r1,#18
  str r1,[r0,#28]
  ; 24
  mov r1,#1
  lsl r1,#12
  str r1,[r0,#8]
  mov r1,#1
  lsl r1,#24
  str r1,[r0,#28]

  bx lr

Draw6:
  ; 12, 15, 16, 18
  mov r1,#1
  lsl r1,#6
  mov r2,#1
  lsl r2,#15
  mov r3,#1
  lsl r3,#18
  mov r4,#1
  lsl r4,#24
  orr r1,r2
  orr r1,r3
  orr r1,r4
  str r1,[r0,#4]
  ; 12
  mov r1,#1
  lsl r1,#12
  str r1,[r0,#28]
  ; 15
  mov r1,#1
  lsl r1,#15
  str r1,[r0,#28]
  ; 16
  mov r1,#1
  lsl r1,#16
  str r1,[r0,#28]
  ; 18
  mov r1,#1
  lsl r1,#18
  str r1,[r0,#28]
  ; 24, 25
  mov r1,#1
  lsl r1,#12
  mov r2,#1
  lsl r2,#15
  orr r1,r2
  str r1,[r0,#8]
  ; 24
  mov r1,#1
  lsl r1,#24
  str r1,[r0,#28]
  ; 25
  mov r1,#1
  lsl r1,#25
  str r1,[r0,#28]

  bx lr

Draw7:
  ; 16
  mov r1,#1
  lsl r1,#18
  str r1,[r0,#4]
  mov r1,#1
  lsl r1,#16
  str r1,[r0,#28]
  ; 21, 24
  mov r1,#1
  lsl r1,#3
  mov r2,#1
  lsl r2,#12
  orr r1,r2
  str r1,[r0,#8]
  ; 21
  mov r1,#1
  lsl r1,#21
  str r1,[r0,#28]
  ; 24
  mov r1,#1
  lsl r1,#24
  str r1,[r0,#28]

  bx lr

Draw8:
  ; 12, 15, 16, 18
  mov r1,#1
  lsl r1,#6
  mov r2,#1
  lsl r2,#15
  mov r3,#1
  lsl r3,#18
  mov r4,#1
  lsl r4,#24
  orr r1,r2
  orr r1,r3
  orr r1,r4
  str r1,[r0,#4]
  ; 12
  mov r1,#1
  lsl r1,#12
  str r1,[r0,#28]
  ; 15
  mov r1,#1
  lsl r1,#15
  str r1,[r0,#28]
  ; 16
  mov r1,#1
  lsl r1,#16
  str r1,[r0,#28]
  ; 18
  mov r1,#1
  lsl r1,#18
  str r1,[r0,#28]
  ; 21, 24, 25
  mov r1,#1
  lsl r1,#3
  mov r2,#1
  lsl r2,#12
  mov r3,#1
  lsl r3,#15
  orr r1,r2
  orr r1,r3
  str r1,[r0,#8]
  ; 21
  mov r1,#1
  lsl r1,#21
  str r1,[r0,#28]
  ; 24
  mov r1,#1
  lsl r1,#24
  str r1,[r0,#28]
  ; 25
  mov r1,#1
  lsl r1,#25
  str r1,[r0,#28]

  bx lr

Draw9:
  ; 12, 15, 16, 18
  mov r1,#1
  lsl r1,#6
  mov r2,#1
  lsl r2,#15
  mov r3,#1
  lsl r3,#18
  mov r4,#1
  lsl r4,#24
  orr r1,r2
  orr r1,r3
  orr r1,r4
  str r1,[r0,#4]
  ; 12
  mov r1,#1
  lsl r1,#12
  str r1,[r0,#28]
  ; 15
  mov r1,#1
  lsl r1,#15
  str r1,[r0,#28]
  ; 16
  mov r1,#1
  lsl r1,#16
  str r1,[r0,#28]
  ; 18
  mov r1,#1
  lsl r1,#18
  str r1,[r0,#28]
  ; 21, 24
  mov r1,#1
  lsl r1,#3
  mov r2,#1
  lsl r2,#12
  orr r1,r2
  str r1,[r0,#8]
  ; 21
  mov r1,#1
  lsl r1,#21
  str r1,[r0,#28]
  ; 24
  mov r1,#1
  lsl r1,#24
  str r1,[r0,#28]

  bx lr
