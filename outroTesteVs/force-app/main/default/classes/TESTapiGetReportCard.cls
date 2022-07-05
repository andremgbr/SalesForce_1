@isTest public class TESTapiGetReportCard {

    @testSetUp static void MeuSetup(){
        //SetUp  
        //Cria Pessoa

        //Teste DataBase
        //Savepoint sp = Database.setSavepoint();

        Pessoa__c p1 = new Pessoa__c(name = 'PessoaTeste',
                                     E_mail__c = 'teste20@teste.com', 
                                     Password__c = 'abc123');
        insert p1;

        Aluno__c a = new Aluno__c(Pessoa__c = p1.id);
        insert a;

        Pessoa__c p2 = new Pessoa__c(name = 'PessoaTeste2',
                                     E_mail__c = 'teste30@teste.com', 
                                     Password__c = 'abc123');
        insert p2;
        
        Professor__C pf = new Professor__C(Pessoa__c = p2.id);
        insert pf;


        Sala__c s = new Sala__c(Endereco__c = 'SALA30');
        insert s;

        Turma__c t = new Turma__c(Ano__c = 2021, 
                                  Ativa__c = True, 
                                  Curso__c = 'Nome do Curso', 
                                  Periodo__c = 'Manhã',
                                  Sala__c = s.id);
        insert t;
        
        Disciplina__c d = new Disciplina__c(Professor__C = pf.id,
                                            Name = 'Nome Disciplina');
        insert d;
        
        Notas__c n = new Notas__c(Aluno__c = a.id, 
                                  Descricao__c = 'Prova Teste 1', 
                                  Disciplina__c = d.id,
                                  Resultado__c = 8,
                                  Turma__c = t.id,
                                  Valor_Total__c = 10);
        insert n;
        
        //Database.rollback(sp);
    }

    @isTest public static void getStudentOK(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestURI = 'https://teste-andremgbr-developer-edition.na213.force.com/services/apexrest/GetCardStudent';
        req.addParameter('email', 'teste30@teste.com');
        req.addParameter('password','abc123');
        req.addHeader('Content-Type', 'application/json');
        req.httpMethod = 'GET';
        req.requestBody = Blob.valueof('{}');

        RestContext.request  = req;
        RestContext.response = res;  

        Test.startTest();
        apiGetReportCard.GetCardStudent();
        Test.stopTest();

        System.AssertEquals(200,res.statusCode);
    }

    @isTest public static void getStudentNotFound(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://teste-andremgbr-developer-edition.na213.force.com/services/apexrest/GetCardStudent';
        req.addParameter('email', 'teste50@teste.com');
        req.addParameter('password','abc123');
        req.addHeader('Content-Type', 'application/json');
        req.httpMethod = 'GET';
        req.requestBody = Blob.valueof('{}');

        RestContext.request  = req;
        RestContext.response = res;  

        Test.startTest();
        apiGetReportCard.GetCardStudent();
        Test.stopTest();

        System.AssertEquals(404,res.statusCode);
    }

    @isTest public static void getStudentPassWordError(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://teste-andremgbr-developer-edition.na213.force.com/services/apexrest/GetCardStudent';
        req.addParameter('email', 'teste30@teste.com');
        req.addParameter('password','aaaa3');
        req.addHeader('Content-Type', 'application/json');
        req.httpMethod = 'GET';
        req.requestBody = Blob.valueof('{}');

        RestContext.request  = req;
        RestContext.response = res;  

        Test.startTest();
        apiGetReportCard.GetCardStudent();
        Test.stopTest();

        System.AssertEquals(401,res.statusCode);
    }
    @isTest public static void getStudentException(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = 'https://teste-andremgbr-developer-edition.na213.force.com/services/apexrest/GetCardStudent';
        req.addParameter('email', 'ERRO_DE_EXCEPTION_TESTE');
        req.addParameter('password','aaaa3');
        req.addHeader('Content-Type', 'application/json');
        req.httpMethod = 'GET';
        req.requestBody = Blob.valueof('{}');

        RestContext.request  = req;
        RestContext.response = res;  

        Test.startTest();
        apiGetReportCard.GetCardStudent();
        Test.stopTest();

        System.AssertEquals(500,res.statusCode);
    }
    

}
