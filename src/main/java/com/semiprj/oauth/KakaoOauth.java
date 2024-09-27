package com.semiprj.oauth;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class KakaoOauth implements Oauth {

    @Value("${kakao.loginform.url}")
    private String LOGIN_FORM_URL;

    @Value("${kakao.client.id}")
    private String CLIENT_ID;

    @Value("${kakao.redirect.uri}")
    private String CALLBACK_URL;

    @Value("${kakao.endpoint.token}")
    private String ENDPOINT_URL_TOKEN;

    @Value("${kakao.endpoint.userinfo}")
    private String ENDPOINT_URL_USERINFO;

    private String ACCESS_TOKEN = "";

    /**
     * 카카오 로그인창 주소
     */
    @Override
    public String getLoginFormURL() {
        Map<String, Object> params = new HashMap<>();
        params.put("response_type", "code");
        params.put("client_id", CLIENT_ID);
        params.put("redirect_uri", CALLBACK_URL);

        String parameterString = params.entrySet().stream()
                .map(x -> x.getKey() + "=" + x.getValue())
                .collect(Collectors.joining("&"));

        return LOGIN_FORM_URL + "?" + parameterString;
    }

    /**
     * AccessToken 받기
     */
    @Override
    public Map<String, String> requestAccessToken(String code) {
        MultiValueMap<String, String> bodys = new LinkedMultiValueMap<>();
        bodys.add("grant_type", "authorization_code");
        bodys.add("client_id", CLIENT_ID);
        bodys.add("redirect_uri", CALLBACK_URL);
        bodys.add("code", code);

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(bodys, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
                ENDPOINT_URL_TOKEN,
                HttpMethod.POST,
                entity,
                new ParameterizedTypeReference<Map<String, String>>() {}
        );

        if (responseEntity.getStatusCode() == HttpStatus.OK) {
            this.ACCESS_TOKEN = responseEntity.getBody().get("access_token");
        }

        return responseEntity.getBody();
    }

    /**
     * AccessToken을 사용해 유저정보 받기
     */
    @Override
    public Map<String, String> getUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        HttpEntity<String> entity = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
                ENDPOINT_URL_USERINFO,
                HttpMethod.GET,
                entity,
                new ParameterizedTypeReference<Map<String, String>>() {}
        );

        return responseEntity.getBody();
    }

    /**
     * refreshToken을 사용해 AccessToken 재발급 받기
     */
    @Override
    public String getAccessTokenByRefreshToken(String refreshToken) {
        MultiValueMap<String, String> bodys = new LinkedMultiValueMap<>();
        bodys.add("grant_type", "refresh_token");
        bodys.add("client_id", CLIENT_ID);
        bodys.add("refresh_token", refreshToken);

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(bodys, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
                ENDPOINT_URL_TOKEN,
                HttpMethod.POST,
                entity,
                new ParameterizedTypeReference<Map<String, String>>() {}
        );

        return responseEntity.getBody().get("access_token");
    }

    /**
     * AccessToken 만료 여부 체크
     */
    @Override
    public boolean isTokenExpired(String accessToken) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "Bearer " + accessToken);
            HttpEntity<String> entity = new HttpEntity<>(headers);

            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<Map<String, Object>> responseEntity = restTemplate.exchange(
                    ENDPOINT_URL_USERINFO,
                    HttpMethod.GET,
                    entity,
                    new ParameterizedTypeReference<Map<String, Object>>() {}
            );
            return false; // 요청 성공 -> 토큰 유효
        } catch (HttpClientErrorException e) {
            if (e.getStatusCode() == HttpStatus.UNAUTHORIZED) {
                return true; // 401 Unauthorized -> 토큰 만료
            }
            throw e; // 다른 오류는 예외로 처리
        }
    }
}
