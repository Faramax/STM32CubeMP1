/**
  @page OpenAMP_FreeRTOS_echo OpenAMP FreeRTOS echo example

  @verbatim
  ******************************************************************************
  * @file    OpenAMP/OpenAMP_FreeRTOS_echo/readme.txt
  * @author  MCD Application Team
  * @brief   Description of the OpenAMP FreeRTOS echo example.
  ******************************************************************************
  *
  * Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  *
  ******************************************************************************
  @endverbatim

@par Application Description

How to use OpenAMP MW with FreeRTOS.

This project deals with CPU2 (Cortex-M4) firmware and requires Linux OS running on CPU1 (Cortex-A7)
OpenAMP MW uses the following HW resources
    * IPCC peripheral for event signal (mailbox) between CPU1(CA7) and CPU2(CM4)
    * MCUSRAM peripheral for buffer communications (virtio buffers) between CPU1(CA7) and CPU2(CM4)
            Reserved shared memeory region for this example: SHM_ADDR=0x10040000 and SHM_SIZE=128k.
            It is defined in platform_info.c file


In this example:
    - CPU2(CM4) initialize OPenAMP MW which initializes/configures IPCC peripheral through HAL
    and setup openamp-rpmsg framwork infrastructure
    - CPU2(CM4) creates 1 rpmsg channels for 1 virtual UART instance: UART0
    - 2 FreeRTOS Thread + 1 semaphore are created and FreeRTOS is launch
    - The first Thread (Idle) make LED7 Blink. it waiting for messages from CPU1(CA7) and release a
      semaphore when a message is received
    - The second Thread try to take the semaphore. When semaphore from the Idle Thread arrive, it
      sends the received message back to CPU1(CA7) threw UART0 and change LED5 state

IMPORTANT NOTE:
The actual bare metal version of OpenAMP is not designed to work with FreeROTS. as a consequence,
it's not advised to use FreeRTOS operations inside OpenAMP interrupts.

    > stty -onlcr -echo -F /dev/ttyRPMSG0
    > cat /dev/ttyRPMSG0 &
    > echo Ping test 0 > /dev/ttyRPMSG0

    You should get "Ping test 0" and "Ping test 1" in Linux console and LED5 had to change state


@note The application needs to ensure that the HAL time base is always set to 1 millisecond
      to have correct HAL operation.


@par Keywords

Middleware, RTOS, FreeRTOS, Thread, OpenAMP


@par Directory contents

    - OpenAMP/OpenAMP_FreeRTOS_echo/Inc/main.h                          Main program header file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Inc/mbox_ipcc.h                     mailbox_ipcc_if.c MiddleWare configuration header file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Inc/openamp.h                       User OpenAMP init header file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Inc/openamp_conf.h                  Configuration file for OpenAMP MW
    - OpenAMP/OpenAMP_FreeRTOS_echo/Inc/FreeRTOSConfig.h             	FreeRTOS Configuration file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Inc/rsc_table.h                     Resource_table for OpenAMP header file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Inc/stm32mp1xx_hal_conf.h         	HAL Library Configuration file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Inc/stm32mp1xx_it.h               	Interrupt handlers header file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/main.c                          Main program
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/mbox_ipcc.c                     mailbox_ipcc_if.c MiddleWare configuration
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/openamp.c                       User OpenAMP init
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/app_FreeRTOS.c               	Code for freertos applications
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/rsc_table.c                     Resource_table for OpenAMP
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/stm32mp1xx_it.c               	Interrupt handlers
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/system_stm32mp1xx.c           	STM32MP1xx system clock configuration file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/stm32mp1xx_hal_msp.c          	MSP Initialization file
    - OpenAMP/OpenAMP_FreeRTOS_echo/Src/stm32mp1xx_hal_timebase_tim.c 	HAL timebase file


@par Hardware and Software environment

  - This example runs on STM32MP157CACx devices.

  - This example has been tested with STM32MP157C-DK2 board and can be
    easily tailored to any other supported device and development board.

@par How to use it ?

In order to make the program work, you must do the following:
 - Open your preferred toolchain
 - Rebuild all files and load your image into target memory
 - Run the example


 * <h3><center>&copy; COPYRIGHT STMicroelectronics</center></h3>
 */
