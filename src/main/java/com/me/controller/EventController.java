package com.me.controller;

import com.me.dao.EventDAO;
import com.me.pojo.Event;
import com.me.pojo.User;
import com.me.validation.EventValidator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@SessionAttributes("myUser")
public class EventController {

    @Autowired
    EventValidator evalidator;

    @RequestMapping(value = "/events.htm")
    public ModelAndView searchEvents(@RequestParam String eventname, @RequestParam String region, @RequestParam String type, EventDAO eventdao, HttpServletRequest request, Map<String, Object> model) {
        if (request.getParameter("id") != null) {
            List<Event> events = eventdao.getFreeEvents();
            ModelAndView mv = new ModelAndView("searchresults");
            model.put("events", events);
            return mv;
        }
        else {
            String payment= "";
            if (request.getParameter("payment") != null) {
                payment= request.getParameter("payment");
            }
            List<Event> events = eventdao.getAllEventsByKeyword(eventname, region, type, payment);
            ModelAndView mv = new ModelAndView("searchresults");
            model.put("events", events);
            return mv;
        }
    }
    
    @RequestMapping(value = "/addevent.htm")
    public ModelAndView addEvent(@ModelAttribute("event") Event event) {
        ModelAndView mv = new ModelAndView("addevent");
        return mv;
    }

    @RequestMapping(value = "/addevent.htm", method = RequestMethod.POST)
    public String eventAdded(@SessionAttribute("myUser") User user, @ModelAttribute("event") Event event, BindingResult result, SessionStatus status, EventDAO eventdao, RedirectAttributes redirectAttributes) {
        event.setCreatorid(user.getUserid());

        evalidator.validate(event, result);
        if (result.hasErrors()) {
            return "addevent";
        }
        status.setComplete();
        redirectAttributes.addFlashAttribute("myUser", user);
        eventdao.createEvent(event);
        if ("admin".equals(user.getRole())) {
            return "redirect:/allevents.htm";
        } else {
            return "redirect:/eventlist.htm";
        }
    }

    @RequestMapping(value = "/eventlist.htm")
    public ModelAndView myEvents(@ModelAttribute("myUser") User user, EventDAO eventdao, Map<String, Object> model) {
        List<Event> events = eventdao.getEventsByCreatorId(user.getUserid());
        model.put("events", events);
        model.put("myUser", user);
        ModelAndView mv = new ModelAndView("myevents");
        return mv;
    }

    @RequestMapping(value = "/delete-event.htm")
    public String deleteEvent(@SessionAttribute("myUser") User user, @RequestParam("id") long id, EventDAO eventdao) {
        eventdao.deleteEvent(id);
        if ("admin".equals(user.getRole())) {
            return "redirect:/allevents.htm";
        } else {
            return "redirect:/eventlist.htm";
        }
    }

    @RequestMapping(value = "/editevent.htm")
    public ModelAndView editEvent(@RequestParam("id") long eventid, EventDAO eventdao, HttpServletRequest request, HttpServletResponse response, Model model) {
        Event event = eventdao.getEventById(eventid);
        ModelAndView mv = new ModelAndView("editevent");
        mv.addObject("event", event);
        return mv;
    }

    @RequestMapping(value = "/update-event.htm")
    public String updateEvent(@RequestParam("eventid") long eventid, @ModelAttribute("event") Event event, BindingResult result, SessionStatus status, EventDAO eventdao, Model model) {
        evalidator.validate(event, result);
        if (result.hasErrors()) {
            event.setEventid(eventid);
            return "editevent";
        }
        eventdao.updateEvent(event);
        return "event-success";
    }

}
