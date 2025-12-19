@isTest
public class https_utraceTest {
    
    //Mock for success response
    private class SucessMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-type', 'application/xml');
            res.setStatusCode(200);
            res.setBody(
                '<query>'+
                '<status>Success</status>'+
                '<country>India</country>'+
                '<city>Nagpur</city>'+
                '</query>');
            return res;
        }
    }
    
    private class FailureMock implements HttpCalloutMock{
        public HTTPResponse respond(HTTPRequest req){
            HttpResponse res =  new HttpResponse();
            res.setStatusCode(404);
            res.setBody('Invalid Request');
            return res;
        }
    }
    
    @isTest
    static void testSuccessRes() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SucessMock());
        
        https_utrace obj = new https_utrace();
        obj.ipAddress = '103.187.249.160';
        obj.getIpAddressDetails();
        Test.stopTest();
        
        Assert.areEqual('Success', obj.locationData.get('status'));
        Assert.areEqual('India', obj.locationData.get('country'));
        Assert.areEqual('Nagpur', obj.locationData.get('city'));
    }
    
    @isTest
    static void testFaildRes() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FailureMock());
        https_utrace obj = new https_utrace();
        obj.ipAddress = '103.187.GFL.LFG';
        Boolean errorThwon = false;
        try{
            obj.getIpAddressDetails();
        } catch(https_utrace.IpGeoException e){
            errorThwon = true;
        }
        Test.StopTest();
        Assert.areEqual(true, errorThwon, 'Exception should be thrown for error response');
        
    }
    
}