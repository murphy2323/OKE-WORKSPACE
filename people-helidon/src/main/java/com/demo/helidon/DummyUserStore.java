package com.demo.helidon;

import java.util.Optional;

import io.helidon.security.provider.httpauth.UserStore;

class DummyUserStore implements UserStore {

	@Override
	public Optional<User> getUser(String loginName) {
		
		return Optional.of(new DummyUser(loginName));
	}
			

	private class DummyUser implements  UserStore.User {
		private String loginName;
		
		DummyUser(String loginName) {
			super();
			this.loginName = loginName;
		}

		@Override
		public String getLogin() {
			
			return loginName;
		}

		@Override
		public char[] getPassword() {
			
			return "password".toCharArray();
		}
		
	}
}
