# MICAz wireless Sensor Network Application

You'll find the base-station application in the
the folder with the same name. To nodes' app,
go for it's folder as well. This app is using
Collection and Dissemination for it's network routing
and it also includes deluge, which means, after the
first time the app is installed, if reprogramming is needed,
it can be done over-the-air. Do not exclude the volumes-at45db.xml
and volumes-stm25p.xml files, they are required for Deluge to work.  
Collected data include:

 - mote voltage;
 - temperature;
 - pressure;
 - humidity;
 - light.

Motes' data should be properly processed and converted.
To install the app in a mote, first build it by typing in a terminal:  

$ make micaz

After the make command, a class MicazMsg.java should be in the
node folder. If you want to process arrived data, you should include
this class in your project. Packets can be received  processed by running the gateway
application available in the SensorNet-UFAL/environmentMonitoring repository.

Mote app instalation (just an example):  

$ make micaz install.3 mib520,/dev/ttyUSB0  

 - where 3 is an axample mote number (different for each mote)  
 - mib520 is the programming interface
 - /dev/ttyUSB0 is the communication port, which might change  

Within the /node/Micaz.h file, you'll find the packet's content
definition. To change the network communication channel, modify
AM_MICAZMSG value, different channel networks cannot communicate
with each other. You can change the sampling time by modifying
the PERIODICITY_MULTIPLIER (currently set for 30s) value.

In order to learn about these motes programming, please refer
to:  

	<http://tinyos.stanford.edu/tinyos-wiki/index.php/TinyOS_Tutorials>
	<http://tinyos.stanford.edu/tinyos-wiki/index.php/Deluge_T2>

If you have some suggestions or questions about this application,
please contact: <geymerson@laccan.ufal.br>
