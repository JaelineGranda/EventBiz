package com.me.controller;

import com.me.dao.EventDAO;
import com.me.dao.UserDAO;
import com.me.pojo.Event;
import com.me.pojo.User;
import com.me.validation.UserValidator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 *
 * @author Jaeline
 */
@Controller
@SessionAttributes({"myUser"})
public class HomeController {

    @Autowired
    UserValidator uvalidator;

    @GetMapping("/login.htm")
    public String loginGet(ModelMap model, User user) {
        model.addAttribute("user", user);
        return "login";
    }

    @RequestMapping("/index.htm")
    public String logout(HttpServletRequest request, SessionStatus sessionStatus) {
        HttpSession session = request.getSession();
        sessionStatus.setComplete();
        session.invalidate();
        return ("index");
    }

    @GetMapping("/register.htm")
    public String registerGet(ModelMap model, User user) {
        model.addAttribute("user", user);
        return "register";
    }

    @RequestMapping(value = "/welcome.htm", method = RequestMethod.GET)
    public ModelAndView welcomePage(@ModelAttribute("event") Event event, @ModelAttribute User myUser, EventDAO eventdao, Map<String, Object> model) {
        List<Event> events = eventdao.getRecentEvents();
        model.put("events", events);
        ModelAndView mv = new ModelAndView("welcome-page");
        return mv;
    }

    @PostMapping("/login.htm")
    public String loginUser(@ModelAttribute("user") User user, HttpServletRequest request, BindingResult result, SessionStatus status, Model model, RedirectAttributes attributes, UserDAO userdao) {
        uvalidator.validateLogin(user, result);
        if (result.hasErrors()) {
            return "login";
        }
        User usercheck = userdao.loginUser(user.getUsername(), user.getPassword(), user.getRole());
        uvalidator.validateLogin(usercheck, result);

        if (result.hasErrors()) {
            return "login";
        }

        attributes.addFlashAttribute("myUser", usercheck);
        HttpSession session = request.getSession();
        session.setAttribute("myUser", usercheck);
        status.setComplete();
        if ("admin".equals(usercheck.getRole())) {
            return "redirect:/allevents.htm";
        } else {
            return "redirect:/welcome.htm";
        }
    }

    @PostMapping("/register.htm")
    public String registerUser(@ModelAttribute("user") User user, HttpServletRequest request, Model model, BindingResult result, SessionStatus status, UserDAO userdao, RedirectAttributes attributes) {
        User u1 = userdao.checkIfUsernameAlreadyExists(user);
        User u2 = userdao.checkIfEmailAlreadyExists(user);
        uvalidator.validate(user, result);
        uvalidator.validateUsername(u1, result);
        uvalidator.validateEmail(u2, result);
        
        if (result.hasErrors()) {
            return "register";
        }  
        userdao.createUser(user);
        HttpSession session = request.getSession();
        session.setAttribute("myUser", user);
        model.addAttribute("myUser", user);
        status.setComplete();
        attributes.addFlashAttribute("myUser", user);
        return "redirect:/welcome.htm";

    }

}
