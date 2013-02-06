Dcm4chee.configure do
  server_home '/home/tower/Apps/dcm4chee-2.17.2-psql'
  jolokia_url 'http://localhost:8080/jolokia'

  repository_name :dcm4chee
  repository_uri 'mysql://pacs:pacs@127.0.0.1/pacsdb'
end
