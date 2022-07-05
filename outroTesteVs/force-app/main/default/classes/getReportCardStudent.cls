global class getReportCardStudent {

    global  class AllDataReport {
        
        @AuraEnabled
        public List<ReportLesson> ListRL;

        @AuraEnabled
        public string curso {get; set;}
    }

    public class ReportLesson {
        @AuraEnabled
        public string disciplina {get; set;}

        @AuraEnabled
        public string descricao {get; set;}

        @AuraEnabled
        public double notaTotal {get; set;}

        @AuraEnabled
        public double resultado {get; set;}
    }

    @AuraEnabled(cacheable=true)
    public  static AllDataReport ReportCard(String IdStudent){

        AllDataReport Data = new AllDataReport();
        
        List<Notas__c> notas = [select id, ALUNO__r.Pessoa__r.Name, DISCIPLINA__r.Name, 
                                        TURMA__r.Name, VALOR_TOTAL__C,
                                        RESULTADO__C, Descricao__c, TURMA__r.Curso__c
                                from Notas__c 
                                where Aluno__r.Pessoa__r.id = :IdStudent
                                and Turma__r.Ativa__c = TRUE];
        
        List<ReportLesson> ListReport = new List<ReportLesson>();

        for (Notas__c nota : notas){
            ReportLesson rl = new ReportLesson();
            rl.disciplina = nota.DISCIPLINA__r.Name;
            rl.notaTotal = nota.VALOR_TOTAL__C;
            rl.resultado = nota.RESULTADO__C;
            rl.descricao = nota.Descricao__c;
            ListReport.add(rl);
        }

        Data.ListRL = ListReport;
        Data.curso = notas.size() > 0 ? notas[0].TURMA__r.Curso__c : null;
        
        return Data;
    }

}