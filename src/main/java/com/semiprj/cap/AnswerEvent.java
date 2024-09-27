package com.semiprj.cap;


import com.semiprj.data.HandleEvent;
import com.semiprj.data.Room;
import com.semiprj.data.RoomStateEventHandler;
import com.semiprj.srv.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.function.Consumer;

@Component
public class AnswerEvent implements EventCapture{

    private final RoomService roomService;

    @Autowired
    public AnswerEvent(RoomService roomService){
        this.roomService = roomService;
    }

    @Override
    public void doAction(String targetClient, HandleEvent handleEvent, Consumer<RoomStateEventHandler> consumer) {

        if(targetClient.equals(handleEvent.getTargetUuid())){
            HandleEvent data = new HandleEvent(handleEvent);
            Room room = roomService.getRoomStore().get( handleEvent.getRoomUuid() );

            RoomStateEventHandler roomStateEventHandler = new RoomStateEventHandler(room, data);
            consumer.accept(roomStateEventHandler);
        }
    }
}
