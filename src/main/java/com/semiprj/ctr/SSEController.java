package com.semiprj.ctr;


import com.semiprj.data.HandleEvent;
import com.semiprj.srv.RoomService;
import com.semiprj.srv.SSEService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;


@RestController
public class SSEController {

    private final RoomService roomService;
    private final SSEService sseService;

    @Autowired
    public SSEController(RoomService roomService, SSEService sseService){
        this.roomService = roomService;
        this.sseService = sseService;
    }
    @CrossOrigin(origins = "https://jw7469.iptime.org:8447")
    @GetMapping("/sse-event/{roomUuid}/{clientUuid}")
    public SseEmitter sseEventBind(
            @PathVariable("roomUuid") String roomUuid ,
            @PathVariable("clientUuid") String clientUuid) {

        System.out.println("[ Event Bind ] \t" +
                "Room : " + roomUuid +
                "\tClient : " + clientUuid);
        return sseService.spawnEmitters(roomUuid, clientUuid);
    }
    @CrossOrigin(origins = "https://jw7469.iptime.org:8447")
    @PostMapping("/handler")
    public HttpStatus handler(@RequestBody HandleEvent handleEvent){
        System.out.println("[ -> Handler ] \t" +
                "Room : " + handleEvent.getRoomUuid() +
                "\tEvent : " + handleEvent.getEventType() +
                "\tClient : " + handleEvent.getClientUuid() +
                " -> " + handleEvent.getTargetUuid() );
        sseService.publish(handleEvent);
        return HttpStatus.OK;
    }
}