package com.demo.helidon;

import java.io.IOException;
import java.util.logging.LogManager;

import org.glassfish.jersey.server.ResourceConfig;

import com.demo.helidon.greet.GreetResource;
import com.demo.helidon.people.PeopleResource;

import io.helidon.config.Config;
import io.helidon.microprofile.server.Server;
import io.helidon.security.Security;
import io.helidon.security.SubjectType;
import io.helidon.security.provider.httpauth.HttpBasicAuthProvider;
import io.helidon.webserver.Routing;
import io.helidon.webserver.ServerConfiguration;
import io.helidon.webserver.jersey.JerseySupport;
import io.helidon.security.webserver.WebSecurity;


public class Main {

    /**
     * Cannot be instantiated.
     */
    private Main() { }


	public static void main(String[] args)  throws IOException {
        startServer();
	}


    /**
     * Start the server.
     * @return the created {@link Server} instance
     * @throws IOException if there are problems reading logging properties
     */
    protected static Server startServer() throws IOException {

        // load logging configuration
        LogManager.getLogManager().readConfiguration(
                Main.class.getResourceAsStream("/logging.properties"));

        // configure HTTP Basic Auth	
       HttpBasicAuthProvider provider =  HttpBasicAuthProvider.builder()
        .realm("helidon")
        .subjectType(SubjectType.USER)
        .userStore(new DummyUserStore())
        .build();
        
       Security security = Security.builder()
               .addProvider(provider)
               .build();

       
       	//ServerConfiguration serverConfiguration = ServerConfiguration.builder().build();
       
       	
       ResourceConfig resourceConfig = new ResourceConfig()
    		    // register JAX-RS resource
    		    .register(PeopleResource.class)
    		    // integrate security
    		    .register(new io.helidon.security.jersey.SecurityFeature(security));
       
    
        Server server = Server.builder()
        		.resourceConfig(resourceConfig)
        	//.addResourceClass(GreetResource.class)
        	//.addResourceClass(PeopleResource.class)
        	.build()
        	.start();
        // Server will automatically pick up configuration from
        // microprofile-config.properties
        //Server server = Server.create();
        //server.start();
        return server;
}	

}
