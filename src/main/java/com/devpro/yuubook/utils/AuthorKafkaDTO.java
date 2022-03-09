package com.devpro.yuubook.utils;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AuthorKafkaDTO {
    private String name;
    private String prevName;
    private String nextName;
}
