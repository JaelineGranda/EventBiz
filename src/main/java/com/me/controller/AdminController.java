/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.me.controller;

import com.me.dao.BookingDAO;
import com.me.dao.EventDAO;
import com.me.dao.UserDAO;
import com.me.pojo.Booking;
import com.me.pojo.Event;
import com.me.pojo.User;
import com.me.validation.UserValidator;
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
public class AdminController {

    @Autowired
    UserValidator uvalidator;

    @RequestMapping(value = "/allevents.htm")
    public ModelAndView allEvents(EventDAO eventdao, Map<String, Object> model) {
        List<Event> events = eventdao.getAllEvents();
        ModelAndView mv = new ModelAndView("allevents");
        model.put("events", events);
        return mv;
    }

    @RequestMapping(value = "/allusers.htm")
    public ModelAndView allUsers(UserDAO userdao, Map<String, Object> model) {
        List<User> users = userdao.getAllUsers();
        ModelAndView mv = new ModelAndView("allusers");
        model.put("users", users);
        return mv;
    }

    @RequestMapping(value = "/allbookings.htm")
    public ModelAndView allBookings(BookingDAO bookingdao, Map<String, Object> model) {
        List<Booking> bookings = bookingdao.getAllBookings();
        ModelAndView mv = new ModelAndView("allbookings");
        model.put("bookings", bookings);
        return mv;
    }
    
    @RequestMapping(value = "/delete-booking.htm")
    public String deleteEvent(@RequestParam("id") long bookingid, BookingDAO bookingdao) {
        bookingdao.deleteBooking(bookingid);
        return "redirect:/allbookings.htm";
    }  

    @RequestMapping(value = "/edituser.htm")
    public ModelAndView editUser(@ModelAttribute("user") User user, UserDAO userdao, HttpServletRequest request, HttpServletResponse response) {
        long userid;
        if (request.getParameter("id") == null) {
            userid = user.getUserid();
        } else {
            userid = Long.parseLong(request.getParameter("id"));
        }

        user = userdao.getUserById(userid);
        ModelAndView mv = new ModelAndView("edituser");
        mv.addObject("user", user);
        return mv;
    }
    
    @RequestMapping(value = "/update-user.htm")
    public String updateUser(@ModelAttribute("user") User user, BindingResult result, SessionStatus status, UserDAO userdao, Model model) {
        uvalidator.validate(user, result);
        if (result.hasErrors()) {
            return "edituser";
        }

        userdao.updateUser(user);
        return "user-success";
    }

    @RequestMapping(value = "/delete-user.htm")
    public String deleteEvent(@RequestParam("id") long id, UserDAO userdao) {
        userdao.deleteUser(id);
        return "redirect:/allusers.htm";
    }  

    @RequestMapping(value = "/adduser.htm")
    public ModelAndView addUser(@ModelAttribute("user") User user, Model model) {
        ModelAndView mv = new ModelAndView("adduser");
        return mv;
    }
 
    @RequestMapping(value = "/adduser.htm", method = RequestMethod.POST)
    public String userAdded(@SessionAttribute("myUser") User myUser, @ModelAttribute("user") User user, BindingResult result, SessionStatus status, UserDAO userdao, RedirectAttributes redirectAttributes) {   
        uvalidator.validate(user, result);
        redirectAttributes.addFlashAttribute("myUser", myUser);
        if (result.hasErrors()) {
            return "adduser";
        }
        status.setComplete();
        
        userdao.createUser(user);
        return "redirect:/allusers.htm";
    }   

    @RequestMapping(value = "/eventdetails.htm")
    public ModelAndView eventDetails(Event event, @RequestParam("id") long eventid, EventDAO eventdao) {
        event = eventdao.getEventById(eventid);
        ModelAndView mv = new ModelAndView("eventdetails");
        mv.addObject("event", event);
        return mv;
    }
}
