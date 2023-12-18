'use strict'; 

const express = require('express');
const bodyParser = require('body-parser');
const { json } = require('body-parser');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();

// APP SET CORS to allow Al Origins
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


//************************************************************************************************************/
//************************************************************************************************************/
//**********                                   ***************************************************************/
//**********         SOME CONFIG               ***************************************************************/
//**********                                   ***************************************************************/
//************************************************************************************************************/
//************************************************************************************************************/

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);

const conn_data = {
  user: 'trocalo_user',
  host: '127.0.0.1',
  database: 'trocalodb',
  password: 'trocalo_pass',
  port: 5432,
}

//const MAX_APPOINTMENTS_RESPONSE = 999
/*
const MAX_APPOINTMENTS_RESPONSE_XDAY = 100
const MAX_CALENDARS_SEARCH  = 9999999
const MAX_DAYS_SEARCH  = 60
*/


/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                          ********************************************** */
/****************      PUBLIC REGISTER USER  18-12-2023    ********************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */

// PROFESSIONAL SHUTDOWN TUTORIAL
// sanitized  31-03-2023 
// validated 31-03-2023
app.route('/public_register_user')
.post(function (req, res) {
   // console.log('professional_shutdown_tutorial INPUT : ', req.body );
   //req.body=sntz_json(req.body,"/professional_shutdown_tutorial")
// ****** Connect to postgre
const { Client } = require('pg')
const client = new Client(conn_data)
client.connect() 

console.log("REQUEST: "+JSON.stringify(req.body))

//let query_reserve =   "INSERT INTO appointment (  date , start_time,  duration,  center_id, confirmation_status, professional_id, patient_doc_id, patient_name,    patient_email, patient_phone1,  patient_age,  app_available, app_status, app_blocked, app_public,  location1, location2, location3, location4, location5, location6,   app_type_home, app_type_center,  app_type_remote, patient_notification_email_reserved , specialty_reserved , patient_address , calendar_id )"   
let query_reserve = `INSERT INTO userCreation (name1, name2, lastName1, lastName2 ) VALUES  
( '${req.body.name1}' , '${req.body.name2}' , '${req.body.lastName1}' , '${req.body.lastName2}' ) RETURNING * 
`

console.log(query_reserve);

const resultado = client.query(query_reserve, (err, result) => {
    //res.status(200).send(JSON.stringify(result)) ;
    if (err) {
      console.log('/public_register_user ERR:'+err ) ;
    }
    else {
    console.log("public_register_user JSON RESPONSE BODY : "+JSON.stringify(result));
    res.status(200).send(JSON.stringify(result)) ;  
    }
    client.end()
})



})