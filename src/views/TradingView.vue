<template>
  <div>

    <h2 class="text-center">Gráfico en vivo valorización Bitcoin Japonés</h2>

    <GChart
      type="LineChart"
      :options="options"
      :data="collectionData"
      :key="componentKey"
    />

    <div class="text-center">
        <MDBBtn color="primary" @click="ActualizarBtn()" > Actualizar </MDBBtn>
    </div> 
    
    <p> </p>

    <h2 class="text-center">Tabla de datos grafico</h2>

    <div class="container" style="width: 350px;">  
        <MDBListGroup vertical>
            <div v-for="(data) in collectionData">
                <div class="row">
                    <div class="col" style="border: 1px solid black">
                        {{data[0]}}
                    </div>
                    <div class="col" style="border: 1px solid black">
                        {{data[1]}}
                    </div>      
                </div>
            </div>
        </MDBListGroup> 
    </div>

    <h2 class="text-center">Tabla de calculos basicos</h2>

    <div class="container" style="width: 350px;">  
        <MDBListGroup vertical>
            <div class="row">
                
                <div class="col" style="border: 1px solid black">
                    Media:
                </div>
                <div class="col" style="border: 1px solid black">
                    {{Valores.Promedio}}
                </div>
            
            </div>

            <div class="row">

                <div class="col" style="border: 1px solid black">
                    Máximo
                </div>
                <div class="col" style="border: 1px solid black">
                    {{Valores.Max}}
                </div>

            </div>

            <div class="row">


                <div class="col" style="border: 1px solid black">
                    Mínimo:
                </div>
                <div class="col" style="border: 1px solid black">
                    {{Valores.Min}}
                </div>

            </div>

            <div class="row">

                <div class="col" style="border: 1px solid black">
                    Desviación Estándar:
                </div>
                <div class="col" style="border: 1px solid black">
                    {{Valores.Desviacion}}
                </div>
            
            </div>


        </MDBListGroup> 
    </div>

    
    
  </div>
</template>
 
<script>
import { GChart } from "vue-google-charts";
import { MDBBtn, MDBListGroup, MDBListGroupItem } from "mdb-vue-ui-kit";
import axios from 'axios';

export default {
  name: "App",
  components: {
    GChart,
    MDBBtn,
    MDBListGroup,
    MDBListGroupItem
  },
  data() {
    return {
        collectionData: [
        ],
        options: {
            chart: {
            title: "Gráfico en vivo de valorización",
            subtitle: "En Bitcoin Japonés"
            },
            width: 1200,
            height: 400
        },
        Valores : [],
        Media: 0,
        Minimo: 0,
        Maximo: 0,
        Desviacion: 0
        };
    },
    methods: {
        async actualizarGrafico(){
            await axios
                .get( "http://164.92.96.206:8081/api/report/" )
                .then( response => {
                    this.collectionData = response.data;
                })
                .catch(( e => console.log( e ) ))
        },
        async actualizarCalculos(){
            await axios
                .post( "http://164.92.96.206:8081/api/report/getCalculus", this.collectionData )
                .then(( response ) => {
                this.Valores = response.data;
                })
                .catch(( error ) => console.log( error ))
        },
        ActualizarBtn(){
            this.componentKey += 1;
            this.actualizarGrafico(),
            this.actualizarCalculos()
        }
    },
    async mounted (){
        await this.actualizarGrafico(),
        await this.actualizarCalculos()
    }
}
</script>