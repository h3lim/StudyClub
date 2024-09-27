package com.semiprj.cap;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Getter
@Setter
@ToString
public class EmitterWrapper {
    String ownerClientUuid;
    SseEmitter sseEmitter;
}
