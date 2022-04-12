package com.conference.util;

import com.conference.entities.Event;
import com.conference.entities.User;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validation {
    private static final Pattern name = Pattern.compile("^\\p{L}{2,20}$");
    private static final Pattern password = Pattern.compile("^[a-zA-Z0-9]{8,20}$");
    private static final Pattern email = Pattern.compile("^[a-zA-Z0-9]{3,30}[@][a-zA-Z0-9]{3,9}.[a-zA-Z0-9]{2,9}$");
    private static final Pattern time = Pattern.compile("^\\d{2}:\\d{2}$");
    private static final Pattern date = Pattern.compile("^\\d{4}-\\d{2}-\\d{2}$");
    private static final Pattern location = Pattern.compile("^.{5,500}$");
    private static final Pattern topic = Pattern.compile("^.{5,50}$");

    private static final Map<PatternString, Pattern> patterns = Map.of(
            PatternString.TOPIC, topic,
            PatternString.DATE, date,
            PatternString.TIME, time,
            PatternString.LOCATION, location,
            PatternString.NAME, name,
            PatternString.PASSWORD, password,
            PatternString.EMAIL, email
    );

    public static boolean validate(PatternString pattern, String toValidate) {
        if (patterns.containsKey(pattern)) {
            Matcher matcher = patterns.get(pattern).matcher(toValidate);
            return matcher.find();
        } else {
            return false;
        }
    }

    public static boolean validateUser(User user){
        if (user == null || user.getPassword() == null || user.getEmail() == null || user.getLastname() == null || user.getName() == null){
            return false;
        }
        boolean isPasswordValid = validate(PatternString.PASSWORD, user.getPassword());
        boolean isEmailValid = validate(PatternString.EMAIL, user.getEmail());
        boolean isNameValid = validate(PatternString.NAME, user.getName());
        boolean isLastnameValid = validate(PatternString.NAME, user.getLastname());
        return isPasswordValid && isEmailValid && isNameValid && isLastnameValid;
    }

    public static boolean validateEvent(Event event){
        if (event == null || event.getTopic() == null || event.getDate() == null || event.getFromtime() == null || event.getTotime() == null || event.getLocation().getAddress() == null){
            return false;
        }
        boolean isDateValid = validate(PatternString.DATE, event.getDate());
        boolean isStartTimeValid = validate(PatternString.TIME, event.getFromtime());
        boolean isEndTimeValid = validate(PatternString.TIME, event.getTotime());
        boolean isLocationValid = validate(PatternString.LOCATION, event.getLocation().getAddress());
        boolean isTopicValid = validate(PatternString.TOPIC, event.getTopic());
        return isTopicValid && isDateValid && isEndTimeValid && isStartTimeValid && isLocationValid;
    }

    public enum PatternString{
        TOPIC,
        NAME,
        EMAIL,
        PASSWORD,
        TIME,
        DATE,
        LOCATION
    }
}
