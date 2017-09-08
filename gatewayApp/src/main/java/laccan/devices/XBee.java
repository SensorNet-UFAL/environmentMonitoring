package laccan.devices;

import com.digi.xbee.api.DigiMeshDevice;
import com.digi.xbee.api.RemoteXBeeDevice;
import com.digi.xbee.api.XBeeNetwork;
import com.digi.xbee.api.exceptions.XBeeException;
import com.digi.xbee.api.utils.HexUtils;

public class XBee {

	//Replace with the serial port where your receiver module is connected.
	private static final String PORT = "/dev/ttyUSB2";
	//Replace with the baud rate of you receiver module.
	private static final int BAUD_RATE = 9600;

	private static final String DATA_TO_SEND = "1";
	private static final String DATA_TO_SEND1 = "0";
	private static final String REMOTE_NODE_IDENTIFIER = "env_16_tem01";

	// Examples of endpoints, cluster ID and profile ID.
	private static final int SOURCE_ENDPOINT = 0xA0;
	private static final int DESTINATION_ENDPOINT = 0xA1;
	private static final int CLUSTER_ID = 0x1554;
	private static final int PROFILE_ID = 0x1234;

	DigiMeshDevice myDevice = new DigiMeshDevice(PORT, BAUD_RATE);
}
