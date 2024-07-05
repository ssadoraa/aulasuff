package com.isadoraverbicario.apirestful.config;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.isadoraverbicario.apirestful.model.Usuario;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.Instant;

@Service
public class TokenService {
    @Value("${api.security.token.secret}")
    private String secret;
    private static final int DURACAO_TOKEN = 15 * 60 * 60 * 1000;  // 15H

    public String gerarToken(Usuario usuario)
        throws IllegalArgumentException, JWTCreationException{
        Algorithm algoritmo = Algorithm.HMAC256(secret);
        String token = JWT.create()
                .withIssuer("com.isadoraverbicario")
                .withSubject(usuario.getUsername()) 
                .withExpiresAt(Instant.now().plus(Duration.ofSeconds(DURACAO_TOKEN)))
                .sign(algoritmo);
        return token;
    }

    public String validarToken(String token)
        throws IllegalArgumentException, JWTVerificationException {
        Algorithm algoritmo = Algorithm.HMAC256(secret);
        return JWT.require(algoritmo)
                  .withIssuer("com.isadoraverbicario")
                  .build()
                  .verify(token) 
                  .getSubject();
    }
}
