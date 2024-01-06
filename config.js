let host = 'localhost'
let ssl = false;

// host = 'achai2.000webhostapp.com';
// ssl = true;

const config =  {
    urlBase:(ssl)?`https://${host}/project-achai`:`http://${host}/project-achai`,  
}

export default config; 