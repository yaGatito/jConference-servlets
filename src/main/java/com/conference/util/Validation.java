package com.conference.util;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Validation {
    private static final Pattern topic = Pattern.compile("^[\\p{L}0-9]{5,50}$");
    private static final Pattern name = Pattern.compile("^\\p{L}{2,20}$");
    private static final Pattern password = Pattern.compile("^[a-zA-Z0-9]{8,20}$");
    private static final Pattern email = Pattern.compile("^[a-zA-Z0-9]{3,30}[@][a-zA-Z0-9]{3,9}.[a-zA-Z0-9]{2,9}$");
    private static final Map<PatternString, Pattern> patterns = Map.of(
            PatternString.TOPIC, topic,
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

    public enum PatternString{
        TOPIC,
        NAME,
        EMAIL,
        PASSWORD
    }
}
