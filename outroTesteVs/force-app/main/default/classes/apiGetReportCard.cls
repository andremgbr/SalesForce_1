@RestResource(urlMapping='/GetCardStudent')
global class apiGetReportCard {

    @HttpGet
    global static void GetCardStudent(){
        
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');

        try {

            Map<String, String> params = RestContext.request.params;
            String email = params.get('email');
            String password = params.get('password');  

            if (email == 'ERRO_DE_EXCEPTION_TESTE'){
                 CalloutException e = new CalloutException();
                throw e;
            }

            List<Pessoa__c> ListPes = [ SELECT id, Password__c 
                                          FROM Pessoa__c 
                                         WHERE E_MAIL__c = :email];
                                         //Campo e-mail é exclusivo.
            
            if (ListPes.size() == 0 ) {
                res.statusCode = 404;
                res.responseBody = Blob.ValueOf('{"error":"E-mail not found"}');      
            } else if (ListPes[0].Password__c <> password){
                res.statusCode = 401;
                res.responseBody = Blob.ValueOf('{"error":"invalid Password"}');
            }else{
                res.statusCode = 200;
                res.responseBody = Blob.valueOf(JSON.serialize((getReportCardStudent.AllDataReport)getReportCardStudent.ReportCard(ListPes[0].id)));
            }
        } catch (Exception e) {
            res.statusCode = 500;
            res.responseBody = Blob.valueOf(e.getMessage());
        }
    }
}