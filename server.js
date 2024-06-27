'use strict'; 

const express = require('express');
const bodyParser = require('body-parser');
const { json } = require('body-parser');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// path Devel
const PATH_PROD_IMG = '../trocalo/public/productImages/'
// path Prod
// const PATH_PROD_IMG = '/productImages/'
//const PATH_PROD_IMG = '/var/www/html/public/productImages/'


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

app.use(bodyParser.urlencoded({ extended: true ,limit: '35mb', parameterLimit: 50000 }));
//app.use(bodyParser.json());

//app.use(express.limit(100000000));
//app.use(express.json({ limit: '12MB' }));

app.use(express.urlencoded({ extended: true }))

app.use(express.json({limit: '25mb'}));
app.use(express.urlencoded({ extended: true , limit: '25mb'}));

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
  if (user_data != null)
  {
  let user_data_session = await create_session(user_data)
  console.log ("PUBLIC LOGIN USER: user_data_session:"+ JSON.stringify(user_data_session))
  //return concat
   return ( { ...user_data_session, ...user_data } )
  }
  else 
  {
    return (null)
  }
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
  /*
  let dateTime= new String(new Date().getTime())
  let userId = new String(userData.id) 
  let token = userId.length()+"-"+userId+dateTime 

  return  token
*/
return "111234token3234"
}

//**************************** */
// ****  VALIDATE TOKEN       ****/
//**************************** */
async function validate_token(token)
{ 
/*
  let aux = token.split("-")
  
  let dateTime= new String(new Date().getTime())
  let userId = new String(userData.id) 
  let token = userId+dateTime 

  return  token
  */

  return 1
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



/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                          ********************************************** */
/****************      DELETE OBJECT 18-12-2023                 ***************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/private_delete_object')
.post(function (req, res) {

  console.log("/private_delete_object REQUEST: "+JSON.stringify(req.body))
    
  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  

  let query_insert_img = `UPDATE user_object SET deleted_by_owner = TRUE  WHERE id= '${req.body.object_id}'  `


 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultado = client.query(query_insert_img, (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+sql ) ;
      console.log(' ERR = '+err ) ;
  }
  else 
  {
    if (result !=null)
      {
        console.log('RESULT private_delete_object'+JSON.stringify(result.rows) ) ;
        client.end()  
        res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  })


 // res.status(200).send(JSON.stringify(saveResult)) ; 
  /*
  // 1 Create a FIle Name
  const filename= "productImage_"+req.body.session_data.id+"_"+req.body.img_num
  
  // 2 Save File in HD
  let auxBase64=req.body.image.split(",")

  saveImageProduct( auxBase64[1] , filename ) 
  
  // 3 Save reference in DB
  let aux = saveImageProductInDB( filename,req.body.session_data , req.body.img_num )
  */
  
  //fs.writeFileSync('productImages/logoaaaae2.png', auxBase64[1], 'base64');

  //fetch(req.body.image).then(res => res.blob()).then(bina => {saveImageProduct(bina)} )
  //const imageblob = b64toBlob(req.body.image) ;
  //get Image
})



/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                          ********************************************** */
/****************      USER UPLOAD IMAGE PRODUCT 18-12-2023     ***************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/user_create_product')
.post(function (req, res) {

  console.log("/user_create_product REQUEST: "+JSON.stringify(req.body))
  let productCreate = user_create_product(req) ; 
  productCreate.then( v => {  console.log("/user_create_product RESPONSE: "+JSON.stringify(v)) ; return (res.status(200).send(JSON.stringify(v))) } )
    
 // res.status(200).send(JSON.stringify(saveResult)) ; 
  /*
  // 1 Create a FIle Name
  const filename= "productImage_"+req.body.session_data.id+"_"+req.body.img_num
  
  // 2 Save File in HD
  let auxBase64=req.body.image.split(",")

  saveImageProduct( auxBase64[1] , filename ) 
  
  // 3 Save reference in DB
  let aux = saveImageProductInDB( filename,req.body.session_data , req.body.img_num )
  */
  
  //fs.writeFileSync('productImages/logoaaaae2.png', auxBase64[1], 'base64');

  //fetch(req.body.image).then(res => res.blob()).then(bina => {saveImageProduct(bina)} )
  //const imageblob = b64toBlob(req.body.image) ;
  //get Image
})




//**************************** */
// **** save Image        ****/
//**************************** */
async function user_create_product(req)
{ 
  const responseQuery =  await saveProductInDB(req.body)
  console.log("result insert: "+JSON.stringify(responseQuery))
  //  responseQuery.then(function(val){  console.log(" Response Query: "+val)} )
  // console.log(" Response Query: "+responseQuery)
  
  //*************************** */
  //      CREATE IMAGES 
  //*************************** */

  if (req.body.image1 !=null )
  {
    let auxBase64=req.body.image1.split(",")
    saveImageProduct( auxBase64[1] , responseQuery.rows[0].img_ref1 ) 
  }
  if (req.body.image2 !=null )
  {
    let auxBase64=req.body.image2.split(",")
    saveImageProduct( auxBase64[1] , responseQuery.rows[0].img_ref2 ) 
  }
  if (req.body.image3 !=null )
  {
    let auxBase64=req.body.image3.split(",")
    saveImageProduct( auxBase64[1] , responseQuery.rows[0].img_ref3 ) 
  }
  if (req.body.image4 !=null )
  {
    let auxBase64=req.body.image4.split(",")
    saveImageProduct( auxBase64[1] , responseQuery.rows[0].img_ref4 ) 
  }
  if (req.body.image5 !=null )
  {
    let auxBase64=req.body.image5.split(",")
    saveImageProduct( auxBase64[1] , responseQuery.rows[0].img_ref5 ) 
  }

}

//**************************** */
// **** save Image        ****/
//**************************** */
async function saveImageProduct(imageB64, filename  )
{ 
  const fs = require('node:fs'); 
  fs.writeFileSync( PATH_PROD_IMG+filename , imageB64, 'base64');
  console.log('File filename SAVED  OK : '+ filename )

}

//************************************ */
// **** SAVE IMAGE REFERENCE IN DB  ****/
//************************************ */
 async function saveProductInDB(product )
{ 
  let json_response=null;

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  

  let timestamp= new Date().getTime();
  let query_insert_img = `INSERT INTO user_object
  ( title, description, alternative1, alternative2, alternative3, 
    others, owner_id , owner_name , img_ref1 , img_ref2, img_ref3, img_ref4, img_ref5, category1, category2, category3 ) 
  VALUES  
  ('${product.name}' , '${product.description}' , '${product.exchange_option1}' , '${product.exchange_option2}' ,'${product.exchange_option3}',
   ${product.exchange_other} ,'${product.session_data.id}' ,'${product.session_data.name} ' 
   , 'img_${product.session_data.id}_1_${timestamp}.jpg' 
   , 'img_${product.session_data.id}_2_${timestamp}.jpg'  
   , 'img_${product.session_data.id}_3_${timestamp}.jpg'  
   , 'img_${product.session_data.id}_4_${timestamp}.jpg'  
   , 'img_${product.session_data.id}_5_${timestamp}.jpg'  
   ,  ${product.category1}
   ,  ${product.category2}
   ,  ${product.category3}
   ) RETURNING * 
  `
 // console.log("QUERY Insert User  :"+query_insert_img);
    console.log("SQL INSER PRODUCT :"+query_insert_img );
    const result =  await client.query(query_insert_img)
    
    //IF SUCCESS FOUND USER
    if (result.rows.length>0 )
    {
    json_response = result  
    }
    
    client.end() 
    console.log("Product Inserted in DB successfully:"+result.rows[0].id)
    return json_response ;

}


/******************************************************************************************************** */
/******************************************************************************************************** */
/****************  reformular para busqueda por parametros ********************************************** */
/****************      SEARCH PUBLIC OBJECTS     26-12-2023     ***************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/public_search_objects')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/public_search_objects  REQUEST: "+JSON.stringify(req.body))
 
  let json_response = null ;
  let timestamp= new Date().getTime();
  let query_search_object = `SELECT * FROM  user_object  WHERE  (deleted_by_owner = FALSE  OR  deleted_by_owner IS  NULL ) AND  ( blocked_due_proposal_accepted = FALSE OR  blocked_due_proposal_accepted IS  NULL )  LIMIT 12  ; 
  `
 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultado = client.query(query_search_object , (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query_search_object ) ;
      console.log(' ERR = '+err ) ;
      client.end()  
  }
  else 
  {
    if (result !=null)
      {
      console.log('RESULT public_search_objects'+JSON.stringify(result.rows) ) ;
      client.end()  
      res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }

  }

  })

})


/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                          ********************************************** */
/****************      SEARCH PUBLIC OBJECTS BY TEXT
 *                          26-12-2023                          ***************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/public_search_objects_by_text')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/public_search_objects_by_text REQUEST: "+JSON.stringify(req.body))
 
  let json_response = null ;
  let timestamp= new Date().getTime();
  let query_search_object = `SELECT * FROM  user_object  WHERE  (deleted_by_owner = FALSE  OR  deleted_by_owner IS  NULL ) AND  ( blocked_due_proposal_accepted = FALSE OR  blocked_due_proposal_accepted IS  NULL )  AND ( UPPER(title) LIKE UPPER('%${req.body.search_text}%') )  ORDER BY id DESC  LIMIT 50  ; 
  `
 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultado = client.query(query_search_object , (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query_search_object ) ;
      console.log(' ERR = '+err ) ;
  }
  else 
  {
    if (result !=null)
      {
      console.log('RESULT public_search_objects'+JSON.stringify(result.rows) ) ;
      res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        res.status(200).send( null ) ;
      }
  }

  })

})





/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                          ********************************************** */
/****************      GET LAST OBJECTS     26-12-2023     ***************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/public_search_objects_last')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/public_search_objects  REQUEST: "+JSON.stringify(req.body))
 
  let json_response = null ;
  let timestamp= new Date().getTime();
  let query_search_object = `SELECT * FROM  user_object  WHERE  (deleted_by_owner = FALSE  OR  deleted_by_owner IS  NULL ) AND  ( blocked_due_proposal_accepted = FALSE OR  blocked_due_proposal_accepted IS  NULL ) ORDER BY id DESC  LIMIT 9  ; 
  `
 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultado = client.query(query_search_object , (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query_search_object ) ;
      console.log(' ERR = '+err ) ;
      client.end()  
  }
  else 
  {
    if (result !=null)
      {
        console.log('RESULT public_search_objects'+JSON.stringify(result.rows) ) ;
        client.end()  
        res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  })

})

/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      SEARCH PUBLIC GET OBJECTS  CATEGORY      ***************************************** */
/****************                    05-02-2024                 ***************************************** */
/****************                                               ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/public_search_objects_by_category')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/public_search_objects_by_category  REQUEST: "+JSON.stringify(req.body))
 
  let json_response = null ;
  let timestamp= new Date().getTime();
  let query_search_object = `SELECT * FROM  user_object  WHERE  (deleted_by_owner = FALSE  OR  deleted_by_owner IS  NULL ) AND  ( blocked_due_proposal_accepted = FALSE OR  blocked_due_proposal_accepted IS  NULL ) 
  AND ( category1 IN (${req.body.search_categories})  OR category2 IN (${req.body.search_categories}) OR category3 IN (${req.body.search_categories})    )  LIMIT 6 ; 
  `
 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultado = client.query(query_search_object , (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query_search_object ) ;
      console.log(' ERR = '+err ) ;
  }
  else 
  {
    if (result !=null)
      {
        console.log('RESULT public_search_objects_by_category'+JSON.stringify(result.rows) ) ;
        client.end()  
        res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  })

})


/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                          ********************************************** */
/****************      GET MY OBJECTS  28-12-2023               ***************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/private_get_my_objects')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_get_my_objects  REQUEST: "+JSON.stringify(req.body))
 
  let json_response = null ;
  let timestamp= new Date().getTime();
//  let query = `SELECT * FROM  user_object WHERE owner_id='${req.body.id}   ';   `
//let query = `SELECT * FROM user_object WHERE owner_id='${req.body.id} AND  (deleted_by_owner != TRUE OR  deleted_by_owner IS  NULL )  ';   `
// AND  ( blocked_due_proposal_accepted = FALSE OR  blocked_due_proposal_accepted IS  NULL )
let query = `SELECT * FROM user_object WHERE owner_id='${req.body.id}' AND  (deleted_by_owner = FALSE OR  deleted_by_owner IS  NULL )   ;`

// console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultado = client.query(query, (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query ) ;
      console.log(' ERR = '+err ) ;
      client.end()  
  }
  else 
  {
    if (result !=null && result.rows!=null  && result.rows.length>0 )
      {
        console.log('RESULT private_get_my_objects'+JSON.stringify(result.rows) ) ;
        client.end()  
        res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  })

})





/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                          ********************************************** */
/****************      GET PARTNER OBJECTS  28-12-2023          ***************************************** */
/****************                                          ********************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/private_get_partner_objects')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_get_partner_objects  REQUEST: "+JSON.stringify(req.body))
 
  let json_response = null ;
  let timestamp= new Date().getTime();
//  let query = `SELECT * FROM  user_object WHERE owner_id='${req.body.id}   ';   `
//let query = `SELECT * FROM user_object WHERE owner_id='${req.body.id} AND  (deleted_by_owner != TRUE OR  deleted_by_owner IS  NULL )  ';   `

let query = `SELECT * FROM user_object WHERE owner_id='${req.body.partner_id}' AND  (deleted_by_owner != TRUE OR  deleted_by_owner IS  NULL );`

// console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultado = client.query(query, (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query ) ;
      console.log(' ERR = '+err ) ;
      client.end()  
  }
  else 
  {
    if (result !=null)
      {
        console.log('RESULT private_get_partner_objects'+JSON.stringify(result.rows) ) ;
        client.end()  
        res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  })

})







/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      GET PROPOSALS RECEIVED                   ***************************************** */
/****************        28-12-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/private_get_proposals_received')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_get_proposals_received  REQUEST: "+JSON.stringify(req.body))
 
  let json_response = null ;
  let timestamp= new Date().getTime();
  let query = `SELECT * FROM  proposal WHERE user_id_destination='${req.body.id}'; 
  `

 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultado = client.query(query, (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query ) ;
      console.log(' ERR = '+err ) ;
  }
  else 
  {
    if (result !=null  && result.rows!=null   && result.rows.length>0 )
      {
        console.log('RESULT private_get_my_objects'+JSON.stringify(result.rows) ) ;
        client.end()  
        res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  client.end()

  })
  
})

/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      GET PROPOSALS SENT                       ***************************************** */
/****************        28-12-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/private_get_proposals_sent')
.post(function (req, res) {

  console.log("/private_get_proposals_sent REQUEST: "+JSON.stringify(req.body))

  private_get_proposals_sent(req).then(result => {console.log("returning:"+JSON.stringify(result) ) ; res.status(200).send(JSON.stringify(result) ); }   )
  
})


async function private_get_proposals_sent(req)
{
  
  let json_response = {}
  //1st get proposals list sent

  let resp = await get_proposals_sent(req)
  if (resp!=null && resp.rows !=null && resp.rows.length >0  )
  {

  //make an array include just proposals ids
  let objects_ids=resp.rows.map(proposal => proposal.dest_object1 ) ;

  let objects= await private_get_product_images(objects_ids)

  json_response.proposals = resp.rows 
  json_response.objects = objects.rows
  
  return json_response  

  }
  else 
  {
    return null
  }

}


async function get_proposals_sent(request_received)
{

  //console.log("function get_proposals_sent :"+JSON.stringify(request_received))

  const { Client } = require('pg')
  const client = new Client(conn_data)
  await client.connect() 
   
  let query_get_proposals = "SELECT * FROM  proposal WHERE user_id_source="+request_received.body.id  ;

  const res = await client.query(query_get_proposals) 
  client.end() 
  return (res)
  


}

async function private_get_product_images(prop_ids)
{
  console.log("objects ids: "+prop_ids)

  const { Client } = require('pg')
  const client = new Client(conn_data)
  await client.connect() 
   
  let query_get_proposals = "SELECT * FROM  user_object WHERE id  IN ("+prop_ids+") "  ;

  const res = await client.query(query_get_proposals) 
  client.end() 
  return (res)

}



/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      PRIVATE CANCEL PROPOSAL                  ***************************************** */
/****************        28-12-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/cancel_proposal')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_cancel_proposal REQUEST: "+JSON.stringify(req.body))
 
  //DELETE FROM table_name WHERE condition
  let query_get_proposals = "DELETE FROM proposal WHERE id="+req.body.object_id  ;

 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultQuery= client.query(query_get_proposals, (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query_get_proposals ) ;
      console.log(' ERR = '+err ) ;
      client.end()  
  }
  else 
  {
    if (result !=null)
      {
      console.log('RESULT private_cancel_proposal'+JSON.stringify(result) ) ;
      client.end()  
      res.status(200).send(JSON.stringify(result) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  client.end()

  })


})



/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      SAVE EXCHANGE PROPOSAL                    ***************************************** */
/****************        28-12-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */


app.route('/save_proposal')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/save_proposal  REQUEST: "+JSON.stringify(req.body))

  let timestamp= new Date().toISOString();

  let sql_columns     = ""
  let sql_columns_val = ""

  sql_columns     = sql_columns.concat( "timestamp" ) 
  sql_columns_val = sql_columns_val.concat( "'"+timestamp+"'" ) 

  sql_columns     = sql_columns.concat( ",updated" ) 
  sql_columns_val = sql_columns_val.concat( ",'"+timestamp+"'" ) 

  sql_columns     = sql_columns.concat( ",user_id_creator" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.session_data.id ) 

  sql_columns     = sql_columns.concat( ",user_id_destination" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.object_wanted.owner_id ) 

  sql_columns     = sql_columns.concat( ",amount" ) 
  sql_columns_val = sql_columns_val.concat( ",10000 " ) 

  sql_columns     = sql_columns.concat( ",status" ) 
  sql_columns_val = sql_columns_val.concat( ",1" ) 

  sql_columns     = sql_columns.concat( ",loop_number" ) 
  sql_columns_val = sql_columns_val.concat( ",1" ) 

  sql_columns     = sql_columns.concat( ",user_id_source" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.session_data.id ) 

  sql_columns     = sql_columns.concat( ",dest_object1" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.object_wanted.id ) 

  sql_columns     = sql_columns.concat( ",source_object1" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.objects_offered[0].id ) 

  if (req.body.objects_offered[1] !=null  )
  {
  sql_columns     = sql_columns.concat( ",source_object2" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.objects_offered[1].id ) 
  }

  if (req.body.objects_offered[2] !=null  )
  {
  sql_columns     = sql_columns.concat( ",source_object3" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.objects_offered[2].id ) 
  }

  if (req.body.objects_offered[3] !=null  )
  {
  sql_columns     = sql_columns.concat( ",source_object4" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.objects_offered[3].id ) 
  }

  if (req.body.objects_offered[4] !=null  )
  {
  sql_columns     = sql_columns.concat( ",source_object5" ) 
  sql_columns_val = sql_columns_val.concat( ","+req.body.objects_offered[4].id ) 
  }
  // set Creator Name 
  if ( req.body.session_data.name !=null  )
  {
  sql_columns     = sql_columns.concat( ",creator_name" ) 
  sql_columns_val = sql_columns_val.concat( ",'"+req.body.session_data.name+"'" ) 
  }
  // set Dest Owner Name
  if ( req.body.object_wanted.owner_name  !=null  )
  {
  sql_columns     = sql_columns.concat( ",dest_owner_name" ) 
  sql_columns_val = sql_columns_val.concat( ",'"+req.body.object_wanted.owner_name+"'" ) 
  }
  // set source Owner Name
  if ( req.body.objects_offered[0].owner_name  !=null )
  {
    sql_columns     = sql_columns.concat( ",source_owner_name" ) 
    sql_columns_val = sql_columns_val.concat( ",'"+req.body.objects_offered[0].owner_name+"'" ) 
  }
  // set proposal_duration
    if ( req.body.proposal_duration !=null )
    {
      sql_columns     = sql_columns.concat( ",proposal_days" ) 
      sql_columns_val = sql_columns_val.concat( ",'"+req.body.proposal_duration+"'" ) 
    }
    
  

// set Propposal Title
if ( req.body.object_wanted.title  !=null  )
{
sql_columns     = sql_columns.concat( ",title" ) 
sql_columns_val = sql_columns_val.concat( ",'"+req.body.object_wanted.title+"'" ) 
}


let sql_query = "INSERT INTO proposal ("+ sql_columns +") VALUES ("+sql_columns_val+") RETURNING * " ; 

console.log("  SQL INSERT PROPOSAL : "+sql_query);

    const resultado = client.query(sql_query, (err, result) => {

    if (err) 
    {
        console.log(' ERROR QUERY = '+sql_query ) ;
        console.log(' ERR = '+err ) ;
        client.end()  
    }
    else 
    {
      if (result !=null  && result.rows!=null  && result.rows.length>0  )
        {
          console.log('RESULT private_get_my_objects'+JSON.stringify(result.rows) ) ;
          client.end()  
          res.status(200).send(JSON.stringify(result.rows) );
        }
        else
        {
          client.end()  
          res.status(200).send( null ) ;
        }
    }

    client.end()
  
    })
    
})






/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      PRIVATE UPDATE PROPOSAL                  ***************************************** */
/****************        05-01-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */


app.route('/private_update_proposal')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_update_proposal  REQUEST: "+JSON.stringify(req.body))

  let timestamp= new Date().toISOString();

  let sql_query = `UPDATE proposal SET 
  user_id_destination = ${req.body.proposal_original.user_id_source}  ,
  user_id_source =  ${req.body.proposal_original.user_id_destination} , 
  
  `

  if (req.body.destObjects[0] != null)
  { sql_query= sql_query+` source_object1 =  ${req.body.destObjects[0].id} ,` }
  else { sql_query= sql_query+` source_object1 = null,` }
  if (req.body.destObjects[1] != null)
  { sql_query= sql_query+` source_object2 =  ${req.body.destObjects[1].id} ,` }
  else { sql_query= sql_query+` source_object2 = null,` }
  if (req.body.destObjects[2] != null)
  { sql_query= sql_query+` source_object3 =  ${req.body.destObjects[2].id} ,` }
  else { sql_query= sql_query+` source_object3 = null,` }
  if (req.body.destObjects[3] != null)
  { sql_query= sql_query+` source_object4 =  ${req.body.destObjects[3].id} ,` }
  else { sql_query= sql_query+` source_object4 = null,` }
  if (req.body.destObjects[4] != null)
  { sql_query= sql_query+` source_object5 =  ${req.body.destObjects[4].id} ,` }
  else { sql_query= sql_query+` source_object5 = null,` }
 
  if (req.body.sourceObjects[0] != null)
  { sql_query= sql_query+` dest_object1 =  ${req.body.sourceObjects[0].id} ,` }
  else { sql_query= sql_query+` dest_object1 =  null,` }
  if (req.body.sourceObjects[1] != null)
  { sql_query= sql_query+` dest_object2 =  ${req.body.sourceObjects[1].id} ,` }
  else { sql_query= sql_query+` dest_object2 =  null,` }
  if (req.body.sourceObjects[2] != null)
  { sql_query= sql_query+` dest_object3 =  ${req.body.sourceObjects[2].id} ,` }
  else { sql_query= sql_query+` dest_object3 =  null,` }
  if (req.body.sourceObjects[3] != null)
  { sql_query= sql_query+` dest_object4 =  ${req.body.sourceObjects[3].id} ,` }
  else { sql_query= sql_query+` dest_object4 =  null,` }
  if (req.body.sourceObjects[4] != null)
  { sql_query= sql_query+` dest_object5 =  ${req.body.sourceObjects[4].id} ,` }
  else { sql_query= sql_query+` dest_object5 =  null,` }

  sql_query= sql_query+` source_owner_name =  '${req.body.proposal_original.dest_owner_name}'  ,
  dest_owner_name =  '${req.body.proposal_original.source_owner_name} ' ,  negotiation_loop='${req.body.proposal_original.negotiation_loop + 1}' 

  WHERE  id=  ${req.body.proposal_original.id}    ; 
  ` 

/*
let sql_query = `UPDATE proposal SET 
   `
  if (req.body.destObjects[0] != null)
  { sql_query= sql_query+` dest_object1 =  ${req.body.destObjects[0].id} ,` }
  else { sql_query= sql_query+` dest_object1 = null,` }
  if (req.body.destObjects[1] != null)
  { sql_query= sql_query+` dest_object2 =  ${req.body.destObjects[1].id} ,` }
  else { sql_query= sql_query+` dest_object2 = null,` }
  if (req.body.destObjects[2] != null)
  { sql_query= sql_query+` dest_object3 =  ${req.body.destObjects[2].id} ,` }
  else { sql_query= sql_query+` dest_object3 = null,` }
  if (req.body.destObjects[3] != null)
  { sql_query= sql_query+` dest_object4 =  ${req.body.destObjects[3].id} ,` }
  else { sql_query= sql_query+` dest_object4 = null,` }
  if (req.body.destObjects[4] != null)
  { sql_query= sql_query+` dest_object5 =  ${req.body.destObjects[4].id} ,` }
  else { sql_query= sql_query+` source_object5 = null,` }
 
  if (req.body.sourceObjects[0] != null)
  { sql_query= sql_query+` source_object1 =  ${req.body.sourceObjects[0].id} ,` }
  else { sql_query= sql_query+` source_object1 =  null,` }
  if (req.body.sourceObjects[1] != null)
  { sql_query= sql_query+` source_object2 =  ${req.body.sourceObjects[1].id} ,` }
  else { sql_query= sql_query+` source_object2 =  null,` }
  if (req.body.sourceObjects[2] != null)
  { sql_query= sql_query+` source_object3 =  ${req.body.sourceObjects[2].id} ,` }
  else { sql_query= sql_query+` source_object3 =  null,` }
  if (req.body.sourceObjects[3] != null)
  { sql_query= sql_query+` source_object4 =  ${req.body.sourceObjects[3].id} ,` }
  else { sql_query= sql_query+` source_object4 =  null,` }
  if (req.body.sourceObjects[4] != null)
  { sql_query= sql_query+` source_object5 =  ${req.body.sourceObjects[4].id} ,` }
  else { sql_query= sql_query+` source_object5 =  null,` }

  sql_query= sql_query+` WHERE id=  ${req.body.proposal_original.id}    ; 
  `
*/

console.log("SQL UPDATE PROPOSAL:"+sql_query);

    const resultado = client.query(sql_query, (err, result) => {

    if (err) 
    {
        console.log(' ERROR QUERY = '+sql_query ) ;
        console.log(' ERR = '+err ) ;
        client.end()  
    }
    else 
    {
      if (result !=null)
        {
          console.log('RESULT private_update_proposal'+JSON.stringify(result.rows) ) ;
          client.end()  
          res.status(200).send(JSON.stringify(result.rows) );
        }
        else
        {
          client.end()  
          res.status(200).send( null ) ;
        }
    }

    client.end()
  
    })
    
    
})









/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      PRIVATE GET OBJECTS PROPOSALS            ***************************************** */
/****************        04-01-2024                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/private_get_objects')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_get_objects REQUEST: "+JSON.stringify(req.body))
 
  let query_get_proposals = "SELECT * FROM  user_object WHERE ID IN ("+req.body.objects_ids+")"  ;

 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultQuery= client.query(query_get_proposals, (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query_get_proposals ) ;
      console.log(' ERR = '+err ) ;
      client.end()  
  }
  else 
  {
    if (result !=null)
      {
      console.log('RESULT private_get_objects'+JSON.stringify(result.rows) ) ;
      client.end()  
      res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  client.end()

  })

})


/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      PRIVATE PROPOSAL ACCEPT                  ***************************************** */
/****************      SET STATUS TO 100                        ***************************************** */
/****************        04-01-2024                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/private_proposal_accept')
.post(function (req, res) {

  console.log("/private_proposal_accept  REQUEST: "+JSON.stringify(req.body))
  private_proposal_accept(req.body.proposal_id).then(result => { res.status(200).send(JSON.stringify(result) ); }   )

 //eq.body.proposal_id
})


//**************************************************** */
// ****  BLOCK OBJECTS                              ****/
//**************************************************** */
async function private_proposal_accept(id)
{  
  //1st Accept Proposal, Update to 100 status in DB
  let objects_list = await accept_proposal(id) 
  console.log("2.- after objects_list "+ JSON.stringify(objects_list) );
  //2nd Mark all objects to BLOCK in DB
  let objects_blocked = await blockObjects(objects_list,id)

  let json_response = {}

  if (objects_blocked != null)
  {
    json_response.response_code = 0  
  } 
  else 
  {
    json_response.response_code = 100   
  }

  return json_response
  
}

//**************************************************** */
// ****  ACCEPT PROPOSAL                            ****/
//**************************************************** */
async function accept_proposal(proposal_id)
{ 
  const { Client } = require('pg')
  const client = new Client(conn_data)
  await client.connect() 
   
  let query_get_proposals = "UPDATE proposal SET  date_acceptance=NOW() ,  status=100 WHERE id='"+proposal_id+"' RETURNING  source_object1,source_object2,source_object3,source_object4,source_object5 ,  dest_object1, dest_object2, dest_object3, dest_object4, dest_object5    "  ;
  
  const res = await client.query(query_get_proposals) 
  client.end() 
  console.log("1.- accept_proposal "+ JSON.stringify(res.rows[0]) );

  return res.rows[0] ;
}


//**************************************************** */
// ****  BLOCK OBJECTS                              ****/
//**************************************************** */
async function blockObjects(object_list,proposal_id)
{ 
  const { Client } = require('pg')
  const client = new Client(conn_data)
  await client.connect() 
  
  let aux_obj_list =  []
  aux_obj_list.push(object_list.source_object1)
  aux_obj_list.push(object_list.source_object2)
  aux_obj_list.push(object_list.source_object3)
  aux_obj_list.push(object_list.source_object4)
  aux_obj_list.push(object_list.source_object5)
   
  aux_obj_list.push(object_list.dest_object1)
  aux_obj_list.push(object_list.dest_object2)
  aux_obj_list.push(object_list.dest_object3)
  aux_obj_list.push(object_list.dest_object4)
  aux_obj_list.push(object_list.dest_object5)
  
  let aux_obj_list_filtered = aux_obj_list.filter(function (el) { return el != null; });

  let query_block_objects = "UPDATE user_object SET blocked_due_proposal_accepted=true, proposal_id_accepted="+proposal_id+"  WHERE id  IN ("+aux_obj_list_filtered+") RETURNING  *  "  ;
 
  console.log("3 -  blockObjects function QUERY : "+query_block_objects);
 
  const res = await client.query(query_block_objects) 
  client.end() 
  console.log("1.- accept_proposal "+ JSON.stringify(res.rows) );
  return res.rows ;
  

}



/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      PRIVATE  PROPOSAL CANCEL                 ***************************************** */
/****************        04-01-2024                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */

app.route('/private_proposal_cancel')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_proposal_cancel  REQUEST: "+JSON.stringify(req.body))
 
  let query_get_proposals = "UPDATE proposal SET status=300 WHERE id='"+req.body.proposal_id+"' "  ;

  /*
  UPDATE table_name
  SET column1 = value1, column2 = value2, ...
  WHERE condition;
  */
 // console.log("QUERY Insert User  :"+query_insert_img);
     
 const resultQuery= client.query(query_get_proposals, (err, result) => {

  if (err) 
  {
      console.log(' ERROR QUERY = '+query_get_proposals ) ;
      client.end()  
      console.log(' ERR = '+err ) ;
  }
  else 
  {
    if (result !=null)
      {
      console.log('RESULT private_proposal_cancel '+JSON.stringify(result.rows) ) ;
      client.end()  
      res.status(200).send(JSON.stringify(result.rows) );
      }
      else
      {
        client.end()  
        res.status(200).send( null ) ;
      }
  }

  client.end()

  })

})















/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      PRIVATE SEND COMMENTS                    ***************************************** */
/****************        08-01-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */


app.route('/private_send_comment')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_send_comment  REQUEST: "+JSON.stringify(req.body))

//{"text_message":"aaaaaaaaaaaa","feeling":2,"timestamp":"2024-01-09T13:27:06.458Z"}

let sql_query = ` INSERT INTO comment 
( timestamp, user_id , comment, feeling, user_name) 
VALUES 
('${req.body.timestamp}', '${req.body.session_data.id}', '${req.body.text_message}', '${req.body.feeling}', '${req.body.session_data.name}'   ) RETURNING *  
;` 

console.log("  SQL INSERT Comment : "+sql_query);

    const resultado = client.query(sql_query, (err, result) => {

    if (err) 
    {
        console.log(' ERROR QUERY = '+sql_query ) ;
        console.log(' ERR = '+err ) ;
        client.end()  
    }
    else 
    {
      if (result !=null  && result.rows!=null && result.rows.length>0  )
        {
        console.log('RESULT private_get_my_objects'+JSON.stringify(result.rows) ) ;
        client.end()  
        res.status(200).send(JSON.stringify(result.rows) );
        }
        else
        {
          client.end()  
          res.status(200).send( null ) ;
        }
    }

    client.end()
  
    })
    
})





/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************      PRIVATE GET  COMMENTS                    ***************************************** */
/****************        08-01-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */


app.route('/private_get_comments')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_get_comments  REQUEST: "+JSON.stringify(req.body))
//{"text_message":"aaaaaaaaaaaa","feeling":2,"timestamp":"2024-01-09T13:27:06.458Z"}

let sql_query = `SELECT * FROM comment WHERE user_id = ${req.body.session_data.id}  ORDER BY id DESC ; `

console.log("private_get_comments : "+sql_query);

    const resultado = client.query(sql_query, (err, result) => {

    if (err) 
    {
        console.log(' ERROR QUERY = '+sql_query ) ;
        console.log(' ERR = '+err ) ;
        client.end()  
    }
    else 
    {
      if (result !=null)
        {
        console.log('RESULT private_get_comments'+JSON.stringify(result.rows) ) ;
        client.end()  
        res.status(200).send(JSON.stringify(result.rows) );
        }
        else
        {
          client.end()  
          res.status(200).send( null ) ;
        }
    }

    client.end()
  
    })
    
})




/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************         GET  ALL COMMENTS                     ***************************************** */
/****************        08-01-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */


app.route('/private_get_all_comments')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_get_all_comments  REQUEST: "+JSON.stringify(req.body))
//{"text_message":"aaaaaaaaaaaa","feeling":2,"timestamp":"2024-01-09T13:27:06.458Z"}

let sql_query = `SELECT * FROM comment   ORDER BY id DESC ; `

console.log("private_get_all_comments : "+sql_query);

    const resultado = client.query(sql_query, (err, result) => {

    if (err) 
    {
        console.log(' ERROR QUERY = '+sql_query ) ;
        console.log(' ERR = '+err ) ;
        client.end()  
    }
    else 
    {
      if (result !=null)
        {
          console.log('RESULT private_get_all_comments'+JSON.stringify(result.rows) ) ;
          client.end()  
          res.status(200).send(JSON.stringify(result.rows) );
        }
        else
        {
          client.end()  
          res.status(200).send( null ) ;
        }
    }

    client.end()
  
    })
    
})


/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************       FIX ISSUE                               ***************************************** */
/****************        08-01-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */


app.route('/private_fix_comment')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_fix_comment  REQUEST: "+JSON.stringify(req.body))
//{"text_message":"aaaaaaaaaaaa","feeling":2,"timestamp":"2024-01-09T13:27:06.458Z"}

let sql_query = "UPDATE comment SET fixed=true WHERE id="+req.body.id+" returning * "

console.log("private_fix_comment : "+sql_query);

    const resultado = client.query(sql_query, (err, result) => {

    if (err) 
    {
        console.log(' ERROR QUERY = '+sql_query ) ;
        console.log(' ERR = '+err ) ;
        client.end()  
    }
    else 
    {
      if (result !=null)
        {
          console.log('RESULT private_fix_comment'+JSON.stringify(result.rows) ) ;
          client.end()  
          res.status(200).send(JSON.stringify(result.rows) );
        }
        else
        {
          client.end()  
          res.status(200).send( null ) ;
        }
    }

    client.end()
  
    })
    
})


/******************************************************************************************************** */
/******************************************************************************************************** */
/****************                                               ***************************************** */
/****************       UNFIX ISSUE                               ***************************************** */
/****************        08-01-2023                             ***************************************** */
/******************************************************************************************************** */
/******************************************************************************************************** */
// Comments:
// 
/******************************************************************************************************** */


app.route('/private_unfix_comment')
.post(function (req, res) {

  const { Client } = require('pg')
  const client = new Client(conn_data)
  client.connect() 
  
  console.log("/private_unfix_comment  REQUEST: "+JSON.stringify(req.body))
//{"text_message":"aaaaaaaaaaaa","feeling":2,"timestamp":"2024-01-09T13:27:06.458Z"}

let sql_query = "UPDATE comment SET fixed=false WHERE id="+req.body.id+" returning * "

console.log("private_unfix_comment : "+sql_query);

    const resultado = client.query(sql_query, (err, result) => {

    if (err) 
    {
        console.log(' ERROR QUERY = '+sql_query ) ;
        console.log(' ERR = '+err ) ;
        client.end()  
    }
    else 
    {
      if (result !=null)
        {
          console.log('RESULT private_unfix_comment'+JSON.stringify(result.rows) ) ;
          client.end()  
          res.status(200).send(JSON.stringify(result.rows) );
        }
        else
        {
          client.end()  
          res.status(200).send( null ) ;
        }
    }

    client.end()
  
    })
    
})


