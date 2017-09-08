/**
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

public class WSN {

	private static WSN wsn = null;
	private List< Pair<String, Integer> > onlineDevices = new ArrayList< Pair<String, Integer> >();

	private WSN(){ }

	public static WSN getInstance(){
		if (wsn == null){
			wsn = new WSN();
		}
		return wsn;
	}

	public void addDevice(Pair<String, Integer> device) {
		onlineDevices.add(device);
	}

	public void clearOnlineList() {
		onlineDevices.clear();
	}
}
