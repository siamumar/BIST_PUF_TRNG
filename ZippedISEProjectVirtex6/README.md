How to Run:

1. Press reset: Push Button: GPIO_SW_E/SW7
2. Set sw[0]:SW1 to '1'
3. Press START:GPIO_SW_W/SW8
4. Wait till LED[8]:GPIO_LED_C/DS16 is ON

1. Press RST: Push Button: GPIO_SW_E/SW7
2. If a test has already been run, press START[1]:GPIO_SW_S/SW6
3. To read unpredictability test results:

	(a) Set sw[0]:SW1 to '1' and sw[1]:SW2 to '0'
	
	(b) Press START[0]:GPIO_SW_W/SW8
	
	(c) Wait till LED[8]:GPIO_LED_C/DS16 is ON
	
	(d) Run eth_sirc_lib_SW_Example and choose option 1.
	
	(e) Run eth_2_data_PUF.m to plot the results.
	
4. To read stability test results:

	(a) Set sw[0]:SW1 to '0' and sw[1]:SW2 to '0'
	
	(b) Press START[0]:GPIO_SW_W/SW8
	
	(c) To stop the tests set SW1 to '1'. LED[8]:GPIO_LED_C/DS16 will turn ON
	
	(d) Run eth_sirc_lib_SW_Example and choose option 2.
	
	(e) Run eth_2_data_PUF_stability to plot the results.
	

