/**
 * Class Name      : https_utrace
 * Purpose         : Performs IP Geolocation lookup using external API and parses XML response.
 * Created By      : Anup Bhitre
 * Created Date    : 20-12-2024
 *
 * Last Modified By: Anup Bhitre
 * Last Modified On: 20-12-2024
 *
 * Revisions:
 * ---------------------------------------------------------------------------
 * Developer        | Date         | Description
 * ---------------------------------------------------------------------------
 * Anup Bhitre      | 20-12-2024   | Initial version
 * <Name>           | <Date>       | <Change details>
 */
public class https_utrace {
    
    public String ipAddress{set;get;}
    public Map<String, String> locationData{set;get;}
    public String xml {set;get;}
 
    public class IpGeoException extends Exception {}
    
    private static final String API_ENDPOINT = 'http://ip-api.com/xml/';
    
    public https_utrace(){
        locationData = new Map<String,String>();
    }
    
    public void getIpAddressDetails() {
        try {
            String xmlResponse = callIpApi();
            xml = xmlResponse;
            parseXmlResponse(xmlResponse);
        } catch (Exception e) {
            throw new IpGeoException('Failed to retrieve IP data: ' + e.getMessage());
        }
    }
    
    @TestVisible
    private String callIpApi() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_ENDPOINT + ipAddress);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
         if (response.getStatusCode() != 200) {
            throw new IpGeoException('API returned status code: ' + response.getStatusCode() + ', Body: ' + response.getBody());
        }
        return response.getBody();
    }
    
    @TestVisible
    private void parseXmlResponse(String xmlContent) {
        Dom.Document doc = new Dom.Document();
        doc.load(xmlContent);
        Dom.XmlNode root = doc.getRootElement(); 
        List<Dom.XmlNode> data = root.getChildElements();
        for(Dom.XmlNode ed : data) {
            locationData.put(ed.getName(), ed.getText());
        }
    }
    
}