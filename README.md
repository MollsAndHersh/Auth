# Sample Service w/ Docker Containers

This project hosts a solution that creates the following:
### Containers
  1. Service
  2. MS SQL Linux
     - Connect to Linux @ LocalHost, 1434
     - Username: sa
     - Password: Password1!
     - The AuthDb database gets created when the container loads for the first time.  The script is written to check for DB/Table existance before attempting to create.
  
### Volumes
  1. Data Volume
     - Database files reside here. (Mount point is /var/lib/db on auth.database container)
    
    
### Authentication Service
  1. Verify working by hitting the URL https://localhost:44355/.well-known/openid-configuration
  
## Testing
Postman files are located in repo to use for testing.
  

