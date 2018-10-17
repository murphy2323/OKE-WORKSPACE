package com.demo.helidon.people;

import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

import personsdb.Person;

public class PersonsService {

	private static final Map<String, String> jpaProperties = new HashMap<>();

	public List<Person> findAll() {
		try {
			if (jpaProperties.isEmpty()) {
				init();
			}
			
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("personsdb", jpaProperties);
	
			//EntityManagerFactory emf = Persistence.createEntityManagerFactory("personsdb");
			EntityManager em = emf.createEntityManager();
			TypedQuery<Person> q = em.createQuery("SELECT p FROM Person p", Person.class);
			List<Person> list = q.getResultList();
			em.close();
			// emf.close();

			return list;
		} catch (Throwable e) {
			System.out.println(e.getMessage());
		}
		return new ArrayList<Person>();
	}

	private void init() {

//		Optional<String> url = Optional.ofNullable(System.getenv("javax_persistence_jdbc_url"));
//		Optional<String> user = Optional.ofNullable(System.getenv("javax_persistence_jdbc_user"));
//		Optional<String> password = Optional.ofNullable(System.getenv("javax_persistence_jdbc_password"));

		System.out.println("------- System environment: " + System.getenv());
		
		Optional<String> url = Optional.ofNullable(System.getenv("javax_persistence_jdbc_url"));
		Optional<String> user = Optional.ofNullable(System.getenv("javax_persistence_jdbc_user"));
		Optional<String> password = Optional.ofNullable(System.getenv("javax_persistence_jdbc_password"));

		
		jpaProperties.put("javax.persistence.jdbc.url", url.orElse("jdbc:oracle:thin:@132.145.36.133:1521:orcl").toString());
		jpaProperties.put("javax.persistence.jdbc.user", user.orElse("username").toString());
		jpaProperties.put("javax.persistence.jdbc.password", password.orElse("password").toString());

		System.out.println("------- jpaProperties: " + jpaProperties);

	}
}
