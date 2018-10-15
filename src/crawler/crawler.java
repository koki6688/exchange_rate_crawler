package crawler;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.*;
import com.fasterxml.jackson.core.*;


public class crawler {


    public static JSONArray getRate(String currency, String currencyTitle) {
// TODO Auto-generated method stub
        String url = "https://www.esunbank.com.tw/bank/Layouts/esunbank/Deposit/DpService.aspx/GetLineChartJson";
        String payload = "{data:{\"Currency\":\"" + currency + "\",\"Currencytype\":\"1\",\"Rangetype\":\"3\"," +
                "\"Startdate\":\"2018-09-16\",\"Enddate\":\"2018-10-16\",\"CurrencyTitle\":\"" + currencyTitle + "\"}}";

        try {
            JSONObject jsonobj = new JSONObject(sendPostRequest(url, payload));
            JSONArray result = new JSONArray("[" + jsonobj.get("d") + "]");
            return result.getJSONObject(0).getJSONArray("Rates");
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static String sendPostRequest(String requestUrl, String payload) {
        StringBuilder jsonString = new StringBuilder();
        try {
            URL url = new URL(requestUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            connection.setDoInput(true);
            connection.setDoOutput(true);
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Referer", " https://www.esunbank.com.tw/bank/personal/deposit/rate/forex/exchange-rate-chart?Currency=USD/TWD");
            connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream(), "UTF-8");
            writer.write(payload);
            writer.close();
            BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));

            String line;
            while ((line = br.readLine()) != null) {
                jsonString.append(line);
            }
            br.close();
            connection.disconnect();
        } catch (Exception e) {
            System.out.println("*****");
            throw new RuntimeException(e.getMessage());
        }
        return jsonString.toString();
    }
}