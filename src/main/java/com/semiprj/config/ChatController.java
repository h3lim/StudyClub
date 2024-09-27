package com.semiprj.config;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ChatController {

    @RequestMapping("/chatting")
    public String chat(Model model){
        return "chat";
    }

    @RequestMapping("/video")
    public String video(Model model){
        return "webRTC3";
    }
}
