<template>
  <div>

    <center> <h2>Gráfico en vivo valorización Bitcoin Japonés</h2> </center>

    <GChart
      type="LineChart"
      :options="options"
      :data="collectionData"
      :key="componentKey"
    />

    <center> 
        <div>
            <MDBBtn color="primary" @click="actualizarGrafico()" > Actualizar </MDBBtn>
        </div> 
    </center>
    
    <p> </p>

    <center> <h2>Tabla de datos grafico</h2> </center>

    <div class="container">  

        <MDBListGroup>
            <div v-for="(data,index) in collectionData" :key="index">
                <MDBListGroupItem flex-fill> {{data[0]}} </MDBListGroupItem>
            </div>
        </MDBListGroup>
        <MDBListGroup >
            <div v-for="(data,index) in collectionData" :key="index">
                <MDBListGroupItem flex-fill> {{data[1]}} </MDBListGroupItem>
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
        }
        };
    },
    methods: {
        actualizarGrafico(){
            this.componentKey += 1;
        }
    },
    async mounted (){
        await axios
            .get( "http://localhost:8080/api/report/" )
            .then( response => {
                this.collectionData = response.data;
            })
            .catch(( e => console.log( e ) ))
        }
    };
</script>