Glassfish
=========
This Dockerfile creates an image that will run Glassfish. It is to be used
as the basis for thin Web-application images.

- https://hub.docker.com/r/thorsager/glassfish/

The is a twist though. To control the behaviour of the applications
Environment variables will be added to Glassfish System.properties.

All environment variables defined in the container at execution of 
entrypoint, with a name starting with `GF_ENV_`, will be transferred to
the Glassfish System.properties, without the `GF_ENV_` prefix.

```bash
  $ export GF_ENV_NAME=Pablo
```
Would be available as:  
```java
  System.getProperty("NAME");
```
The System.properties can also be referenced in resources defined in 
`domain.xml` added by `asadmin`

Admin
-----
The admin-password for remote admin of the GlassFish is `glassfish` 
this cannot be change at _runtime_ a new image must be build for this
to be altered. 

Debugging
---------
If the `DEBUG` environment variable is set _(non-zero length)_ debug
will be enabled and debugger will be exposed on port 9009.


