COMPONENT=SenseAppC
SENSORBOARD=mts400
BOOTLOADER=tosboot

CLEAN_EXTRA=*.class MicazMsg.java
CFLAGS += -I$(TOSDIR)/lib/net \
          -I$(TOSDIR)/lib/net/le \
          -I$(TOSDIR)/lib/net/ctp
BUILD_EXTRA_DEPS += MicazMsg.class

MicazMsg.class: MicazMsg.java
	javac MicazMsg.java

MicazMsg.java:
	mig java -target=micaz -java-classname=MicazMsg Micaz.h micazMsg -o $@

include $(MAKERULES)
