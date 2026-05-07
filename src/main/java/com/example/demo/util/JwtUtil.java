package com.example.demo.util;

import java.security.Key;
import java.util.Date;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

public class JwtUtil {

	private static final String SECRET_KEY = "fuelnova_secret_key_fuelnova_secret_key";

	private static final Key key = Keys.hmacShaKeyFor(SECRET_KEY.getBytes());

	public static String generateToken(String email) {

		return Jwts.builder().setSubject(email).setIssuedAt(new Date())
				.setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60))
				.signWith(key, SignatureAlgorithm.HS256).compact();
	}

	public static String extractEmail(String token) {

		Claims claims = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token).getBody();

		return claims.getSubject();
	}

	public static boolean validateToken(String token, String email) {

		String extractedEmail = extractEmail(token);

		return extractedEmail.equals(email);
	}
}
