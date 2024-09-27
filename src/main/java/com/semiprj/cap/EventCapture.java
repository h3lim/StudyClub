package com.semiprj.cap;

import com.semiprj.data.HandleEvent;
import com.semiprj.data.RoomStateEventHandler;

import java.util.function.Consumer;


@FunctionalInterface
public interface EventCapture {
//    void doAction(String targetClient, HandleEvent handleEvent, Consumer<RoomStateEventHandler> runnable);

    void doAction(String targetClient, HandleEvent handleEvent, Consumer<RoomStateEventHandler> consumer);
}
