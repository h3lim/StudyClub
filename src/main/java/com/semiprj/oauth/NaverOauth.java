package com.semiprj.oauth;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
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
public class NaverOauth implements Oauth {

    @Value("${naver.loginform.url}")
    private String LOGIN_FORM_URL;
    @Value("${naver.client.id}")
    private String CLIENT_ID;
    @Value("${naver.client.pw}")
    private String CLIENT_PW;
    @Value("${naver.redirect.uri}")
    private String CALLBACK_URL;
    @Value("${naver.endpoint.token}")
    private String ENDPOINT_URL_TOKEN;
    @Value("${naver.endpoint.userinfo}")
    private String ENDPOINT_URL_USERINFO;
    private String ACCESS_TOKEN = "";

    /**
     * 네이버의 로그인창 주소
     */
    @Override
    public String getLoginFormURL() {
        Map<String, Object> params = new HashMap<>();
        params.put("response_type", "code");
        params.put("client_id", CLIENT_ID);
        params.put("redirect_uri", CALLBACK_URL);
        params.put("state", "random_state");

        String parameterString = params.entrySet().stream()
                .map(entry -> entry.getKey() + "=" + entry.getValue())
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
        bodys.add("client_secret", CLIENT_PW);
        bodys.add("redirect_uri", CALLBACK_URL);
        bodys.add("code", code);

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(bodys, headers);
        RestTemplate restTemplate = new RestTemplate();
        try {
            ResponseEntity<Map> responseEntity = restTemplate.exchange(
                    ENDPOINT_URL_TOKEN,
                    HttpMethod.POST,
                    entity,
                    Map.class
            );

            Map<String, String> bodyMap = responseEntity.getBody();
            this.ACCESS_TOKEN = (String) bodyMap.get("access_token");
            System.out.println("2.토큰 응답(body): " + bodyMap.toString());
            System.out.println("2.토큰 응답(token): " + ACCESS_TOKEN);

            return (Map<String, String>) bodyMap;
        } catch (HttpClientErrorException e) {
            System.err.println("HTTP 상태 코드: " + e.getStatusCode());
            System.err.println("응답 바디: " + e.getResponseBodyAsString());
            throw e;
        }
    }

    /**
     * AccessToken을 사용해 유저정보 받기
     */
    @Override
    public Map<String, String> getUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        HttpEntity<Map<String, String>> entity = new HttpEntity<>(headers);
        RestTemplate restTemplate = new RestTemplate();
        try {
            ResponseEntity<Map> responseEntity = restTemplate.exchange(
                    ENDPOINT_URL_USERINFO,
                    HttpMethod.POST,
                    entity,
                    Map.class
            );
            System.out.println("5.유저정보: " + responseEntity.getBody().toString());
            return (Map<String, String>) responseEntity.getBody().get("response");
        } catch (HttpClientErrorException e) {
            System.err.println("HTTP 상태 코드: " + e.getStatusCode());
            System.err.println("응답 바디: " + e.getResponseBodyAsString());
            throw e;
        }
    }

    /**
     * refreshToken을 사용해 AccessToken 재발급 받기
     */
    @Override
    public String getAccessTokenByRefreshToken(String refreshToken) {
        MultiValueMap<String, String> bodys = new LinkedMultiValueMap<>();
        bodys.add("grant_type", "refresh_token");
        bodys.add("client_id", CLIENT_ID);
        bodys.add("client_secret", CLIENT_PW);
        bodys.add("refresh_token", refreshToken);

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(bodys, headers);
        RestTemplate restTemplate = new RestTemplate();
        try {
            ResponseEntity<Map> responseEntity = restTemplate.exchange(
                    ENDPOINT_URL_TOKEN,
                    HttpMethod.POST,
                    entity,
                    Map.class
            );

            return (String) responseEntity.getBody().get("access_token");
        } catch (HttpClientErrorException e) {
            System.err.println("HTTP 상태 코드: " + e.getStatusCode());
            System.err.println("응답 바디: " + e.getResponseBodyAsString());
            throw e;
        }
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
            ResponseEntity<Map> responseEntity = restTemplate.exchange(
                    ENDPOINT_URL_USERINFO,
                    HttpMethod.POST,
                    entity,
                    Map.class
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
