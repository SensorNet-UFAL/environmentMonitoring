package laccan.devices;

import laccan.gatewayApp.EnvironmentMonitor;
import laccan.gatewayApp.Server;
import net.tinyos.message.Message;
import net.tinyos.message.MessageListener;
import net.tinyos.message.MoteIF;
import net.tinyos.packet.BuildSource;
import net.tinyos.packet.PhoenixSource;
import net.tinyos.util.PrintStreamMessenger;

public class Micaz implements MessageListener  {

	private static String nativeLibraryPath =
			System.getProperty("user.dir") + "/sense_lib/native/Linux/x86_64-unknown-linux-gnu/";

	//	static {
	////		System.load(nativeLibraryPath + "libgetenv.so");
	////		System.load(nativeLibraryPath + "libtoscomm.so");
	//	}

	private PhoenixSource phoenix;
	private MoteIF mif;	
	private long msDate;
	
	 //nodeID
	private int nodeID;
	//light sensor
	private double light;
	//temperature = [0] ºC, humidity = [1] %
	private double[] temperatureHumidity = new double[2];
	//temperature = [0] ºC, pressure = [1] millibar
	private double[] temperaturePressure = new double[2];
	//Current node voltage (in millivolt)
	private double voltage;
	//Node location
	private String environment;

	public Micaz(final String source){
		phoenix = BuildSource.makePhoenix(source, PrintStreamMessenger.err);
		mif = new MoteIF(phoenix);
		mif.registerListener(new MicazMsg(),this);
	}

	public void messageReceived(int dest_addr, Message msg) {
		msDate = System.currentTimeMillis();	//Get current date
		processPacket(msg);
		printData(); //Display sensor data
		Server.saveData(toServerString(msg)); //Send to cloud
	}
	
	private void processPacket(Message message) {
		if(message instanceof MicazMsg) {
			//Get packet
			MicazMsg tempMessage = (MicazMsg) message;
			
			nodeID = tempMessage.get_nodeid();
			
			try {
				environment = EnvironmentMonitor.environments[(nodeID - 1)/ 5];
			} catch (ArrayIndexOutOfBoundsException e) {
				environment = "unknownEnvironment";
				System.out.println("Unexpected environment id error.");
			}
			
			light =
					calculateTaosLight(tempMessage.get_VisLight_data(),tempMessage.get_InfLight_data());

			temperatureHumidity =
					calculateSensirion(tempMessage.get_Temp_data(),tempMessage.get_Hum_data());
			
			temperaturePressure[0] = tempMessage.getElement_Intersema_data(0)/10;
			temperaturePressure[1] = tempMessage.getElement_Intersema_data(1)/10;
					
			voltage =
					(1223 * 1024)/tempMessage.get_Voltage_data();
			return;
		}
		System.out.println("Unable to process packet.");
		return;
	}

	private double calculateTaosLight(int visibleLight, int infraredLight) {
		final int CHORD_VAL[] = {0,16,49,115,247,511,1039,2095};
		final int STEP_VAL[] = {1,2,4,8,16,32,64,128};
		int chordNumber, stepNumber, ch0Counts, ch1Counts;

		chordNumber = (visibleLight>>4) & 7;
		stepNumber = visibleLight & 15;
		ch0Counts = CHORD_VAL[chordNumber] + stepNumber * STEP_VAL[chordNumber];

		chordNumber = (infraredLight>>4) & 7;
		stepNumber = infraredLight & 15;
		ch1Counts = CHORD_VAL[chordNumber] + stepNumber * STEP_VAL[chordNumber];

		double pConst = -3.13 * ch1Counts/ch0Counts;
		return ch0Counts * 0.46 * Math.exp(pConst);
	}

	private double[] calculateSensirion(int Temperature, int Humidity){
		double [] converted = new double[2];
		converted[0] = -39.4+(0.01*(double)Temperature);
		converted[1] = (-2.0468+0.0367*(double)Humidity-0.0000015955*Math.pow((double)Humidity,(double )2))
				+ (converted[0]-25)*(0.01+0.00008*(double)Humidity);
		return converted;
	}	
	
	@SuppressWarnings("unused")
	private void printData() {
		System.out.println("Measured micaz data:");
		System.out.println();
		System.out.println("Node:                   "+nodeID);
		System.out.println("NodeType:               "+"micaz");
		System.out.println("Environment id:\t\t" 	 +environment);
		System.out.printf("Sensirion temperature:  %.2f\n",temperatureHumidity[0]);
		System.out.printf("Sensirion humidity:     %.2f\n",temperatureHumidity[1]);
		System.out.println("Intersema temperature:  "+temperaturePressure[0]);
		System.out.println("Intersema pressure:     "+temperaturePressure[1]);
		System.out.printf("Taos light:             %.2f\n",light);
		System.out.println("Voltage:                "+voltage);		
		System.out.println("Country:                "+"Brazil");
		System.out.println("State:                	"+"Alagoas");
		System.out.println("City:                	"+"Maceio");
		System.out.println("Latitude:               "+"-9.555032");
		System.out.println("Longitude:              "+"-35.774708");	
		System.out.println("date:\t\t\t" + msDate);
	}
	
	//Save sensor data to a formatted server string
	@SuppressWarnings("unused")
	private String toServerString(Message message) {
		String data = String.format("nodeID=%s&nodeType=%s&"
				+ "env_id=%s&sensirion_temp=%s&sensirion_hum=%s&"
				+ "intersema_temp=%s&intersema_press=%s&light=%s&"
				+ "voltage=%s&country=%s&state=%s&city=%s&"
				+ "latitude=%s&longitude=%s&"
				+ "date=%s",
				nodeID,"micaz", environment,
				temperatureHumidity[0], temperatureHumidity[1],
				temperaturePressure[0], temperaturePressure[1], light,
				voltage, "Brazil", "Alagoas", "Maceio",
				"-9.555032", "-35.774708",
				msDate);
		return data;
	}
}