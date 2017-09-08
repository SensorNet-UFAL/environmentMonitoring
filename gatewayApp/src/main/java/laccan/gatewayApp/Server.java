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

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class Server {

	private static String serverURL = "my server address";
	private String databaseName;
	private String dataString;

	void setServerURL(String url) {
		this.serverURL = url;
	}

	String getServerURL() {
		return serverURL;
	}

	void setDatabaseName(String database) {
		this.databaseName = database;
	}

	String getDatabaseName() {
		return databaseName;
	}

	void setDataString(String dataString) {
		this.dataString = dataString;
	}

	String getDataString() {
		return dataString;
	}

	public static void saveData(String data) {
		try {

			//Set URL address
			URL url = new URL(serverURL);

			//Request connection
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();

			//Set request type
			conn.setRequestMethod("POST");
			//Set request properties
			conn.setRequestProperty("User-Agent", "Mozilla/5.0");
			conn.setRequestProperty("Accept-Language", "pt-br");
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			conn.setRequestProperty("charset", "UTF-8");
			conn.setDoOutput(true);

			//Write data to server
			DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
			wr.writeBytes(data);

			//Close connection
			wr.close();

			System.out.println("\nSending 'POST' request to URL : " + url);
			System.out.println("Response Code : " + conn.getResponseCode());


		} catch (MalformedURLException e) {
			System.out.println("A malformed URL exception has occurred"+ e.getMessage());
		} catch (IOException e) {
			System.out.println("Error:"+ e.getMessage());
		}
	}
}
