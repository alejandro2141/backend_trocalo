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
/****************      PUBLIC LOGIN USER  18-12-2023    ********************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */

/******************************************************************************************************** */
app.route('/public_login_user')
.post(function (req, res) {
   // console.log('professional_shutdown_tutorial INPUT : ', req.body );
   //req.body=sntz_json(req.body,"/professional_shutdown_tutorial")

let response = public_login_user(req) 
response.then( v => {  console.log("/public_login_user RESPONSE: "+JSON.stringify(v)) ; return (res.status(200).send(JSON.stringify(v))) } )
    


})
//**************************** */
// **** public_login_user   ****/
//**************************** */
async function public_login_user(req)
{
  //    LOGIN USER
  let user_data = await login_user(req)
  console.log ("PUBLIC LOGIN USER: user_data:"+JSON.stringify(user_data))
  //    CREATE SESION
  let user_data_session = await create_session(user_data)
  console.log ("PUBLIC LOGIN USER: user_data_session:"+ JSON.stringify(user_data_session))
  //return concat
   return ( { ...user_data, ...user_data_session } )

}

//*************************** */
// ****  LOGIN USER        ****/
//*************************** */
async function login_user(req)
{
  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 

  let query_login = ` SELECT id, 
  names, last_name1, last_name2, email, phone, address_street_name, address_street_apartment, address_location_zone, address_street_number, address_reference, status, active, id_number    
  FROM user_created 
  WHERE 
  email='${req.body.user}' AND passwd='${req.body.pass}' ; 
  `
  const result = await client.query(query_login) 
  //IF SUCCESS FOUND USER
  if (result!=null && result.rows!=null && result.rows.length>0 )
  {
    client.end()   
    return result.rows[0]
  }
  else 
  { client.end() 
    return null 
  }
 
}

//**************************** */
// ****  CREATE SESSION     ****/
//**************************** */
async function create_session(userData)
{
  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 

  let token=await create_token(userData)
  


  let query_insert_session_data = `INSERT INTO session 
  (creation_date ,  user_id , user_name , exp_date , token , token_exp_date , last_login) 
  VALUES  
  ('${new Date().toISOString() }' , '${userData.id}' , '${userData.names}' , '${new Date().toISOString()}' , '${token}' ,'${new Date().toISOString()}' , '${new Date().toISOString()}' ) 
  RETURNING * 
  `
  const result = await client.query(query_insert_session_data) 
  //IF SUCCESS 
  if (result!=null && result.rows!=null && result.rows.length>0 )
  {
    client.end() 
    return result.rows[0]
  }
  else 
  { client.end() 
    return null 
  }
}

//**************************** */
// ****  CREATE TOKEN       ****/
//**************************** */
async function create_token(userData)
{
  let dateTime= new String(new Date().getTime())
  let userId = new String(userData.id) 
  let token = userId.length()+"-"+userId+dateTime 

  return  token
}

//**************************** */
// ****  VALIDATE TOKEN       ****/
//**************************** */
async function validate_token(token)
{ 

  let aux = token.split("-")
  
  let dateTime= new String(new Date().getTime())
  let userId = new String(userData.id) 
  let token = userId+dateTime 

  return  token

}



/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                          ********************************************** */
/****************      PUBLIC REGISTER USER  18-12-2023    ********************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// sanitized  31-03-2023 
// validated 31-03-2023
/******************************************************************************************************** */
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

//************************************  */
//        INSERT USER_CREATION
//************************************  */
let query_insert_user_creation = `INSERT INTO user_creation 
(names , last_name1, last_name2 , email, phone, id_number, passwd, address_street_name, address_street_number , address_street_apartment , address_location_zone , address_reference) 
VALUES  
('${req.body.names}' , '${req.body.last_name1}' , '${req.body.last_name2}' , '${req.body.email}' ,'${req.body.phone}','${req.body.id_number}'
,'${req.body.passwd}','${req.body.address_street_name}','${req.body.address_street_number}','${req.body.address_street_apartment}','${req.body.address_location_zone}','${req.body.address_reference}'    ) RETURNING * 
`
console.log("QUERY Insert User Creation :"+query_insert_user_creation);

const resultado = client.query(query_insert_user_creation, (err, result) => {
    //res.status(200).send(JSON.stringify(result)) ;
    if (err) {
      console.log('/public_register_user ERR:'+err ) ;
    }
    else {
    console.log("public_register_user JSON RESPONSE BODY : "+JSON.stringify(result.rows[0]));
    }
    client.end()
})


//************************************  */
//        INSERT USER
//************************************  */

const client2 = new Client(conn_data)
client2.connect() 

console.log("REQUEST: "+JSON.stringify(req.body))

let query_insert_user = `INSERT INTO user_created 
(names , last_name1, last_name2 , email, phone, id_number, passwd, address_street_name, address_street_number , address_street_apartment , address_location_zone , address_reference) 
VALUES  
('${req.body.names}' , '${req.body.last_name1}' , '${req.body.last_name2}' , '${req.body.email}' ,'${req.body.phone}','${req.body.id_number}'
,'${req.body.passwd}','${req.body.address_street_name}','${req.body.address_street_number}','${req.body.address_street_apartment}','${req.body.address_location_zone}','${req.body.address_reference}'    ) RETURNING * 
`

console.log("QUERY Insert User  :"+query_insert_user);
const resultado2 = client2.query(query_insert_user, (err, result) => {
  //res.status(200).send(JSON.stringify(result)) ;
  if (err) {
    console.log('/public_register_user query_insert_user ERR:'+err ) ;
  }
  else {
  console.log("public_register_user query_insert_user JSON RESPONSE BODY : "+JSON.stringify(result));
  }
  
  res.status(200).send(JSON.stringify(result)) ; 
  client2.end()

})



 

})
