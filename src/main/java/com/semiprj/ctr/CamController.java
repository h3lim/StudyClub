package com.semiprj.ctr;


import com.semiprj.data.Room;
import com.semiprj.data.RoomAccessInfo;
import com.semiprj.srv.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;


@RestController
public class CamController {

    private final RoomService roomService;

    @Autowired
    CamController(RoomService roomService){
        this.roomService = roomService;
    }

    @PostMapping("/create-room")
    public ResponseEntity<RoomAccessInfo> createRoom(){
        return ResponseEntity
                .status(HttpStatus.OK)
                .body( roomService.createRoom() );
    }


    @GetMapping("/room/{roomUuid}")
    public ResponseEntity<Room> getRoom(@PathVariable("roomUuid") String roomUuid) {
        if (roomService.isInvalidRoom(roomUuid)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(null);
        }
        return ResponseEntity
                .status(HttpStatus.OK)
                .body( roomService.getRoomStore().get(roomUuid) );
    }

    @GetMapping("/rooms")
    public ResponseEntity< Map<String, Room> > getRooms() {
        return ResponseEntity
                .status(HttpStatus.OK)
                .body( roomService.getRoomStore()) ;
    }

    @PostMapping("/join-room/{roomUuid}")
    public ResponseEntity<RoomAccessInfo> joinRoom(@PathVariable("roomUuid") String roomUuid){
        if ( roomService.isInvalidRoom(roomUuid) ) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(null);
        }

        RoomAccessInfo response = roomService.joinRoom(roomUuid);
        System.out.println("\n------------------------------------------------------------------------");
        System.out.println("[ Join Room ] \t" + response);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body( response );
    }


}
