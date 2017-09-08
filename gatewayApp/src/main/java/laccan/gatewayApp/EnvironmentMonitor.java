/**
 *	This class will contain environment related
 * 	definitions such as rooms, environment measuring
 *	parameters, processing methods etc.
 *
 *
 *  @author <Geymerson Ramos>
 *  @email: <geymerson@laccan.ufal.com>
 *	Universidade Federal de Alagoas - UFAL
 *	Laboratório de Computação Científica e Análise Numérica - LACCAN
 *
 *	last update at August 19, 2017
 **/

package laccan.gatewayApp;

import java.util.ArrayList;
import java.util.List;

public class EnvironmentMonitor {

	public EnvironmentMonitor() {
		lowerAndUpperLimits.add(new Pair(15.0, 50.0)); // temperature	[15, 50] ºC
		lowerAndUpperLimits.add(new Pair(30.0, 100.0)); // humidity		[30, - ]  %
		lowerAndUpperLimits.add(new Pair(995.0, 1010.0)); // pressure	[995, 1010] milibar
		lowerAndUpperLimits.add(new Pair(100.0, 400.0)); // luminosity	[100, 400] lux
		lowerAndUpperLimits.add(new Pair(0, 100)); // acceleration	[100, 400] lux
	}

	private List<Pair<Float, Float>> lowerAndUpperLimits = new ArrayList<Pair<Float, Float>>();

	public static final String[] environments = {
			"lab_15", "lab_16", "lab_17", "lab_18_1",
			"lab_18_2", "lab_18_3", "room_19", "room_20",
			"room_21", "room_22", "room_23"
	};

	public boolean temperatureCheck(float envTemp) {
		if(envTemp <= lowerAndUpperLimits.get(0).getFirst()) {
			//TODO do something
			return true;
		}
		else if(envTemp >= lowerAndUpperLimits.get(0).getSecond()) {
			//TODO do something
			return true;
		}
		return false;
	}

	public boolean humidityCheck(float envHum) {
		if(envHum <= lowerAndUpperLimits.get(1).getFirst()) {
			//TODO do something
			return true;
		}
		else if(envHum >= lowerAndUpperLimits.get(1).getSecond()) {
			//TODO do something
			return true;
		}
		return false;
	}

	public boolean pressureCheck(float envPressure) {
		if(envPressure <= lowerAndUpperLimits.get(2).getFirst()) {
			//TODO do something
			return true;
		}
		else if(envPressure >= lowerAndUpperLimits.get(2).getSecond()) {
			//TODO do something
			return true;
		}
		return false;
	}

	public boolean luminosityCheck(float envLight) {
		if(envLight <= lowerAndUpperLimits.get(3).getFirst()) {
			//TODO do something
			return true;
		}
		else if(envLight >= lowerAndUpperLimits.get(3).getSecond()) {
			//TODO do something
			return true;
		}
		return false;
	}


	public boolean accelerationCheck(float envAccel) {
		if(envAccel <= lowerAndUpperLimits.get(4).getFirst()) {
			//TODO do something
			return true;
		}
		else if(envAccel >= lowerAndUpperLimits.get(4).getSecond()) {
			//TODO do something
			return true;
		}
		return false;
	}
}
