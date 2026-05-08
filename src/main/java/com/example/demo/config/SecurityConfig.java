package com.example.demo.config;

import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;

import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.security.web.SecurityFilterChain;

import com.example.demo.Model.pojos.User;
import com.example.demo.Model.repository.UserRepository;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

	// ================= REPOSITORY =================

	private final UserRepository userRepository;

	// ================= CONSTRUCTOR =================

	public SecurityConfig(UserRepository userRepository) {

		this.userRepository = userRepository;
	}

	// ================= PASSWORD ENCODER =================

	@Bean
	PasswordEncoder passwordEncoder() {

		return new BCryptPasswordEncoder();
	}

	// ================= USER DETAILS SERVICE =================

	@Bean
	UserDetailsService userDetailsService() {

		return (email) -> {

			User user = userRepository

					.findByEmail(email)

					.orElseThrow(() ->

					new UsernameNotFoundException(

							"User not found : " + email));

			return new org.springframework.security.core.userdetails.User(

					user.getEmail(),

					user.getPassword(),

					user.isActive(),

					true,

					true,

					true,

					List.of(

							new SimpleGrantedAuthority(

									"ROLE_" + user.getRole().name())));
		};
	}

	// ================= AUTH PROVIDER =================

	@Bean
	DaoAuthenticationProvider authProvider(UserDetailsService userDetailsService) {

		DaoAuthenticationProvider provider =

				new DaoAuthenticationProvider(userDetailsService);

		provider.setPasswordEncoder(passwordEncoder());

		return provider;
	}

	// ================= AUTH MANAGER =================

	@Bean
	AuthenticationManager authManager(AuthenticationConfiguration config) throws Exception {

		return config.getAuthenticationManager();
	}

	// ================= SECURITY FILTER =================

	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		http

				// TEMPORARILY DISABLE CSRF

				.csrf(csrf -> csrf.disable())

				// AUTHORIZATION

				.authorizeHttpRequests(auth -> auth

						.requestMatchers(

								"/",

								"/login",

								"/register",

								"/css/**",

								"/js/**",

								"/images/**",

								"/h2-console/**"

						).permitAll()

						// ADMIN

						.requestMatchers("/admin/**")

						.hasRole("ADMIN")

						// MANAGER

						.requestMatchers("/branch/**")

						.hasAnyRole("ADMIN", "MANAGER")

						// USER

						.requestMatchers("/user/**", "/order/**")

						.hasAnyRole("USER", "ADMIN", "MANAGER")

						// IMPORTANT

						.anyRequest().permitAll())

				// LOGIN

				.formLogin(form -> form

						.loginPage("/login")

						.loginProcessingUrl("/login")

						.usernameParameter("email")

						.passwordParameter("password")

						.successHandler((request, response, authentication) -> {

							boolean isAdmin = authentication

									.getAuthorities()

									.stream()

									.anyMatch(a ->

									a.getAuthority()

											.equals("ROLE_ADMIN"));

							boolean isManager = authentication

									.getAuthorities()

									.stream()

									.anyMatch(a ->

									a.getAuthority()

											.equals("ROLE_MANAGER"));

							if (isAdmin) {

								response.sendRedirect("/admin/dashboard");
							}

						else if (isManager) {

								response.sendRedirect("/branch/dashboard");
							}

						else {

								response.sendRedirect("/user/dashboard");
							}

						})

						.failureUrl("/login?error=true")

						.permitAll())

				// LOGOUT

				.logout(logout -> logout

						.logoutUrl("/logout")

						.logoutSuccessUrl("/login?logout=true")

						.invalidateHttpSession(true)

						.deleteCookies("JSESSIONID")

						.permitAll());

		return http.build();
	}
}