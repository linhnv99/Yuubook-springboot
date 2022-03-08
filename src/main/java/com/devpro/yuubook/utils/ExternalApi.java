package com.devpro.yuubook.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.net.URI;

@Component
public class ExternalApi {
    @Autowired
    private RestTemplate restTemplate;

    public <T> ResponseEntity<T> exchange(RequestEntity<?> requestEntity, Class<T> responseType) {
        return restTemplate.exchange(requestEntity, responseType);
    }

    public <T> ResponseEntity<T> exchange(RequestEntity<?> requestEntity, ParameterizedTypeReference<T> responseType) {
        return restTemplate.exchange(requestEntity, responseType);
    }

    public <T> ResponseEntity<T> postForEntity(URI url, Object requestObject, Class<T> responseType) {
        return restTemplate.postForEntity(url, requestObject, responseType);
    }

    public <T> ResponseEntity<T> getForEntity(URI url, Class<T> responseType) {
        return restTemplate.getForEntity(url, responseType);
    }
}
