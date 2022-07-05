import { LightningElement, api } from 'lwc';
import ReportCard from '@salesforce/apex/getReportCardStudent.ReportCard';
//import TurmaAtiva from '@salesforce/apex/getReportCardStudent.TurmaAtiva'


const columns = [
    { label: 'Disciplina', fieldName: 'disciplina', type:'string' },
    { label: 'Descrição', fieldName: 'descricao', type:'string' },
    { label: 'Nota Distribuida', fieldName: 'notaTotal', type: 'number' },
    { label: 'Resultado', fieldName: 'resultado', type: 'number' }
];

export default class StudentCard extends LightningElement {

    @api recordId;
    data = [];
    columns = columns;

    turma = "";

    // eslint-disable-next-line @lwc/lwc/no-async-await
    connectedCallback() {
        this.getReport();
        // this.getTurma();
    }

    getReport() {
        ReportCard({ IdStudent : this.recordId})
             .then(result =>{
                //  console.log(this.recordId);
                //  console.log("Resultado do Objeto");
                //  console.log(result);
                 this.data = result.ListRL;
                 this.turma = result.curso != null ? "Turma - " + result.curso : "Sem Turma Ativa";
             }, error => {
                 console.log(error);
             });
    }

    // getTurma(){
    //     TurmaAtiva({ IdStudent : this.recordId})
    //          .then(result =>{
    //              if (result){
    //                  console.log(result);
    //                  this.turma = "Boletim Turma - " + result.Turma__r.Curso__c;
    //              } else {
    //                 console.log(this.recordId);
    //                  this.turma ="Turma ativa não encontrada";
    //              }
    //          }, error =>{
    //             console.log(error);
    //          });
    // }
}