@isTest
public class TESTgetReportCardStudent {
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
    
    @isTest static void TESTReportCard(){        
        //Execut
        Test.startTest();
        Aluno__c al = [SELECT id, Pessoa__r.id FROM Aluno__C limit 1];
        getReportCardStudent.AllDataReport alldata = getReportCardStudent.ReportCard(al.Pessoa__r.id);
        Test.stopTest();

        //Validation
        //Creating Expected Object
        getReportCardStudent.AllDataReport resultData = new getReportCardStudent.AllDataReport();
        getReportCardStudent.ReportLesson rp = new getReportCardStudent.ReportLesson();
        rp.disciplina = 'Nome Disciplina';
        rp.descricao = 'Prova Teste 1';
        rp.notaTotal = 10;
        rp.resultado = 8;
        resultData.ListRL = new List<getReportCardStudent.ReportLesson>();
        resultData.ListRL.add(rp);
        resultData.curso = 'Nome do Curso';
        //End of Creating Expected Object

        System.assert(String.valueOf(resultData) == String.valueOf(alldata) ,'Objeto esperado: '+resultData + ', Atual: '+alldata);
    }

}
