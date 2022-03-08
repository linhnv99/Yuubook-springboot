package com.devpro.yuubook.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.net.URI;

@Component
public class KafkaUtils {
    @Value("${external.api.url}")
    private String baseUrl;

    @Value("${external.api.key}")
    private String apiKey;

    @Autowired
    private ExternalApi externalApi;

    public <T> String pushKafka(String type, String action, T data) {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        headers.add("API_KEY", apiKey);

        RequestEntity<BodyTemplate<T>> requestEntity =
                new RequestEntity<>(new BodyTemplate<>(type, action, data),
                        headers, HttpMethod.POST, URI.create(baseUrl + "/kafka/push"));
        String response = externalApi.exchange(requestEntity, String.class).getBody();
        System.out.println("Response: " + response + "- Action: " + action + "- Type: " + type);
        return response;
    }
}
