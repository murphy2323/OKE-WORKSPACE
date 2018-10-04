package com.demo.helidon;

import java.io.IOException;
import java.net.InetAddress;
import java.util.logging.LogManager;


import com.demo.helidon.people.PeopleResource;

import io.helidon.security.Security;
import io.helidon.security.SubjectType;
import io.helidon.security.provider.httpauth.HttpBasicAuthProvider;
import io.helidon.webserver.Routing;
import io.helidon.webserver.ServerConfiguration;
import io.helidon.webserver.WebServer;
import io.helidon.webserver.jersey.JerseySupport;
import io.helidon.webserver.zipkin.ZipkinTracerBuilder;
import io.opentracing.util.GlobalTracer;
import io.opentracing.Tracer;


public class MainWS {

	public static void main(String[] args) throws IOException {
		startServer();
	}

	protected static WebServer startServer() throws IOException {

		// load logging configuration
		LogManager.getLogManager().readConfiguration(Main.class.getResourceAsStream("/logging.properties"));

		// needed for default connection of Jersey client
		// to allow our headers to be set
		System.setProperty("sun.net.http.allowRestrictedHeaders", "true");

		// configure HTTP Basic Auth
		HttpBasicAuthProvider provider = HttpBasicAuthProvider.builder().realm("helidon").subjectType(SubjectType.USER)
				.userStore(new DummyUserStore()).build();

		Security security = Security.builder().addProvider(provider).build();

		ServerConfiguration serverConfiguration = ServerConfiguration.builder()

                .bindAddress(InetAddress.getLocalHost())
                .port(8080)
				.tracer(registerTracer()).build();

		Routing routingBuilder = Routing.builder()
	       .register("/jersey", 
	                 JerseySupport.builder()
	                              .register(PeopleResource.class) 
	                              .register(new io.helidon.security.jersey.SecurityFeature(security))
	                              .build())
	       .build();
		
		WebServer webServer = WebServer.create(serverConfiguration, routingBuilder);
		System.out.println("Listening on " + webServer.port());	
		webServer.start();
		
		return webServer;
	}

	/**
	 * Create a {@code Tracer} instance using the given {@code Config}.
	 * 
	 * @param config
	 *            the configuration root
	 * @return the created {@code Tracer}
	 */
	private static Tracer registerTracer() {
		Tracer tracer = ZipkinTracerBuilder.forService("Backend").zipkinHost("0.0.0.0").build();
		
		GlobalTracer.register(tracer);
		return GlobalTracer.get();
	}
}
