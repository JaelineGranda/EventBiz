/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.me.validation;

import com.me.dao.UserDAO;
import com.me.pojo.User;
import java.util.regex.Pattern;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author Jaeline
 */
public class UserValidator implements Validator {

    private static final Pattern EMAIL_REGEX = Pattern.compile("^[\\w\\d._-]+@[\\w\\d.-]+\\.[\\w\\d]{2,6}$");
    private static final Pattern LETTER_REGEX = Pattern.compile("^[A-Za-z]*$");
    private static final int min_password = 8;
    private static final int min_username = 5;

    @Override
    public boolean supports(Class<?> type) {
        return User.class.isAssignableFrom(type);
    }

    @Override
    public void validate(Object o, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "empty-username", "Username is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstname", "empty-firstname", "First name is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastname", "empty-lastname", "Last name is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "empty-email", "Email is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "empty-password", "Password is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "role", "empty-role", "Role is not selected");
        User user = (User) o;
        if (!user.getUsername().isBlank()
                && user.getUsername().trim().length() < min_username) {
            errors.rejectValue("username", "", "Username must be at least [" + min_username + "] characters in length");
        }

        if (!user.getPassword().isBlank()
                && user.getPassword().trim().length() < min_password) {
            errors.rejectValue("password", "", "Password must be at least [" + min_password + "] characters in length");
        }

        if (!user.getPassword().isBlank() && user.getPassword().contains(" ")) {
            errors.rejectValue("password", "", "Password cannot contain a space");
        }

        if (!user.getEmail().isBlank() && !EMAIL_REGEX.matcher(user.getEmail()).matches()) {
            errors.rejectValue("email", "", "Email is invalid");
        }

        if (!user.getFirstname().isBlank() && !LETTER_REGEX.matcher(user.getFirstname()).matches()) {
            errors.rejectValue("firstname", "", "First name can only contain letters");
        }

        if (!user.getLastname().isBlank() && !LETTER_REGEX.matcher(user.getLastname()).matches()) {
            errors.rejectValue("lastname", "", "Last name can only contain letters");
        }

    }

    public void validateLogin(Object o, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "empty-username", "Username is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "empty-password", "Password is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "role", "empty-role", "Role is not selected");
        User user = (User) o;
            
        if (user == null) {
            errors.reject("user", "Incorrect username/password");
        }
        
    }
    
    public void validateEmail(Object o, Errors errors) {
        User user = (User) o;
            
        if (user != null) {
            errors.reject("user", "Email already exists");
        }
    }
    
    public void validateUsername(Object o, Errors errors) {
        User user = (User) o;
        
        if (user != null) {
            errors.reject("user", "Username already exists");
        }  
    }

}
