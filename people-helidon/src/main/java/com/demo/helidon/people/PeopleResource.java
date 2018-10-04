package com.demo.helidon.people;

import java.util.List;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import io.helidon.security.annot.Authenticated;
import personsdb.Person;

@Path("/persons")
@RequestScoped
public class PeopleResource {

    private final PersonsService service = new PersonsService();


    /**
     * Using constructor injection to get a configuration property.
     * By default this gets the value from META-INF/microprofile-config
     * @param greetingConfig the configured greeting message
     */
    @Inject
    public PeopleResource() {
    }

    @Authenticated(optional=false)
    @Path("/")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getDefaultMessage() {
    	System.out.println("+++++++++++++++++++++ persons");
    	List<Person> persons = service.findAll();
    	return persons;
    }

 
}