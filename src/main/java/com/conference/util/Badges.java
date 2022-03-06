package com.conference.util;

import java.util.List;

public class Badges {
    private static final List<String> badges = List.of(
            "bg-primary",
            "bg-secondary",
            "bg-success",
            "bg-danger",
            "bg-warning",
            "bg-info",
            "bg-dark"
    );
    public String getBadge(){
        return badges.get((int) (Math.random()*(badges.size()-1)));
    }
}
