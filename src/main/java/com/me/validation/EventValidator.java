/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.me.validation;

import com.me.pojo.Event;
import java.util.regex.Pattern;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 *
 * @author Jaeline
 */
public class EventValidator implements Validator {

    private static final Pattern DATE_REGEX = Pattern.compile("\\d{2}-\\d{2}-\\d{4}");
    private static final Pattern LETTER_REGEX = Pattern.compile("^[A-Za-z]*$");
    private static final Pattern CITY_REGEX = Pattern.compile("^[a-zA-Z ]+$");
    private static final Pattern NUM_REGEX = Pattern.compile("^[0-9]*$");
    public static final int len_zipcode = 5;
    public static final int len_state = 2;

    @Override
    public boolean supports(Class<?> type) {
        return Event.class.isAssignableFrom(type);
    }

    @Override
    public void validate(Object o, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "eventname", "empty-eventname", "Event name is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "region", "empty-region", "Region is not selected");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "street", "empty-street", "Street is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "city", "empty-city", "City is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "state", "empty-state", "State is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "zipcode", "empty-zipcode", "Zipcode is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "eventdate", "empty-eventdate", "Event date is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "type", "empty-type", "Event type is required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "price", "empty-price", "Event price is required (if free, enter 0)");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "imagefile", "empty-imagefile", "Image filename is required");
        Event event = (Event) o;
        if (event.getPrice() != null && event.getPrice() < 0) {
            errors.rejectValue("price", "", "Price is invalid");
        }

        if (event.getPrice() != null && event.getPrice().isNaN()) {
            errors.rejectValue("price", "", "Price should be a number.");
        }

        if (!event.getZipcode().isBlank()
                && event.getZipcode().trim().length() != len_zipcode) {
            errors.rejectValue("zipcode", "", "Zipcode must be " + len_zipcode + " characters in length");
        }

        if (!event.getState().isBlank()
                && event.getState().trim().length() != len_state) {
            errors.rejectValue("state", "", "State must be " + len_state + " characters in length");
        }

        if (!event.getEventdate().isBlank() && !DATE_REGEX.matcher(event.getEventdate()).matches()) {
            errors.rejectValue("eventdate", "", "Date is not valid format");
        }

        if (!event.getState().isBlank() && !LETTER_REGEX.matcher(event.getState()).matches()) {
            errors.rejectValue("state", "", "State can only contain letters");
        }
        
        if (!event.getCity().isBlank() && !CITY_REGEX.matcher(event.getCity()).matches()) {
            errors.rejectValue("city", "", "City can only contain letters");
        }
        
        if (!event.getZipcode().isBlank() && !NUM_REGEX.matcher(event.getZipcode()).matches()) {
            errors.rejectValue("zipcode", "", "Zipcode can only contain numbers");
        }       

    }

}
