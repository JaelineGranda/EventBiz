package com.me.controller;

import com.me.dao.BookingDAO;
import com.me.dao.EventDAO;
import com.me.pojo.Booking;
import com.me.pojo.Event;
import com.me.pojo.User;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes({"myUser"})
public class BookingController {
    
    @RequestMapping(value = "/bookevent.htm", method = RequestMethod.GET)
    public ModelAndView bookEvent(@ModelAttribute("booking") Booking booking, @RequestParam("id") long id, EventDAO eventdao, Event event, HttpServletRequest request, HttpServletResponse response) {
        LocalDate date = LocalDate.now();
        ModelAndView mv = new ModelAndView("bookevent");
        event = eventdao.getEventById(id);
        mv.addObject("event", event);
        mv.addObject("date", date);
        return mv;
    }
    
    @RequestMapping(value = "/confirmation.htm")
    public ModelAndView confirmbooking(Booking booking, BookingDAO bookingdao, EventDAO eventdao) {
        bookingdao.createBooking(booking);
        ModelAndView mv = new ModelAndView("confirmation");
        mv.addObject("booking", booking);
        mv.addObject("event", eventdao.getEventById(booking.getEventid()));
        return mv;
    }
    
    @RequestMapping(value = "/mybookings.htm")
    public ModelAndView myBookings(@ModelAttribute("myUser") User user, Map<String, Object> model, BookingDAO bookingdao, EventDAO eventdao) {
        List<Booking> bookings = bookingdao.getUserBookings(user.getUserid());
        List<Event> events = new ArrayList<Event>();
        for (Booking booking: bookings) {
            if(eventdao.getEventById(booking.getEventid()) != null) {
                events.add(eventdao.getEventById(booking.getEventid()));
            }
        }
        ModelAndView mv = new ModelAndView("mybookings");
        model.put("bookings", bookings);
        model.put("events", events);
        return mv;
    }
    
    @RequestMapping(value="/eventbookings.htm")
    public ModelAndView myEventBookings(@ModelAttribute("myUser") User user, Map<String, Object> model, EventDAO eventdao, BookingDAO bookingdao) {
        List<Event> events = eventdao.getEventsByCreatorId(user.getUserid());
        List<Booking> bookings = new ArrayList<Booking>();
        for (Event event: events) {
            if(bookingdao.getEventBooking(event.getEventid())!= null) {
                bookings.add(bookingdao.getEventBooking(event.getEventid()));
            }
        }
        ModelAndView mv = new ModelAndView("mybookings");
        model.put("bookings", bookings);
        return mv;
    }
    
}

